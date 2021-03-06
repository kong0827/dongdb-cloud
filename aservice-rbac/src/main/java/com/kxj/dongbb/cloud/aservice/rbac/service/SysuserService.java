package com.kxj.dongbb.cloud.aservice.rbac.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.kxj.dongbb.cloud.aservice.rbac.config.DbLoadSysConfig;
import com.kxj.dongbb.cloud.aservice.rbac.feign.SmsFeignClient;
import com.kxj.dongbb.cloud.starter.persistence.auto.mapper.SysUserMapper;
import com.kxj.dongbb.cloud.starter.persistence.auto.model.SysUser;
import com.kxj.dongbb.cloud.starter.persistence.auto.model.SysUserExample;
import com.kxj.dongbb.cloud.starter.persistence.rbac.mapper.SystemMapper;
import com.kxj.dongbb.cloud.starter.persistence.rbac.model.SysUserOrg;
import com.kxj.dongbb.cloud.starter.web.exception.CustomException;
import com.kxj.dongbb.cloud.starter.web.exception.CustomExceptionType;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class SysuserService {

    @Resource
    private SysUserMapper sysUserMapper;
    @Resource
    private SystemMapper systemMapper;
    @Resource
    private PasswordEncoder passwordEncoder;
    @Resource
    private DbLoadSysConfig dbLoadSysConfig;
    @Resource
    private SmsFeignClient smsFeignClient;

    public SysUser getUserByUserName(String userName) {
        if (!StringUtils.isEmpty(userName)) {
            SysUserExample sysUserExample = new SysUserExample();
            sysUserExample.createCriteria().andUsernameEqualTo(userName);

            List<SysUser> querys =
                    sysUserMapper.selectByExample(sysUserExample);

            if (querys.size() > 0) {
                //因为数据需要返回给前端，所以置空密码
                querys.get(0).setPassword("");
            }
            return querys.size() > 0 ? querys.get(0) : null;
        } else {
            throw new CustomException(CustomExceptionType.USER_INPUT_ERROR,
                    "查询参数用户名不存在");
        }
    }

    public PageInfo<SysUserOrg> queryUser(Integer orgId,
                                          String username,
                                          String phone,
                                          String email,
                                          Boolean enabled,
                                          Date createStartTime,
                                          Date createEndTime,
                                          Integer pageNum,
                                          Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<SysUserOrg> sysUserOrgs = systemMapper.selectUser(orgId, username, phone, email, enabled,
                createStartTime,
                createEndTime);
        return PageInfo.of(sysUserOrgs);

    }


    public void updateUser(SysUser sysuser) {
        if (sysuser.getId() == null) {
            throw new CustomException(CustomExceptionType.USER_INPUT_ERROR,
                    "修改操作必须带主键");
        } else {
            sysUserMapper.updateByPrimaryKeySelective(sysuser);
        }
    }

    public void addUser(SysUser sysuser) {
        sysuser.setPassword(passwordEncoder.encode(
                dbLoadSysConfig.getConfigItem("user.init.password")
        ));
        sysuser.setCreateTime(new Date());  //创建时间
        sysuser.setEnabled(true); //新增用户激活
        sysUserMapper.insert(sysuser);
    }

    public void deleteUser(Integer userId) {
        sysUserMapper.deleteByPrimaryKey(userId);
    }


    public void pwdReset(Integer userId) {
        if (userId == null) {
            throw new CustomException(CustomExceptionType.USER_INPUT_ERROR,
                    "重置密码必须带主键");
        } else {
            SysUser sysUser = sysUserMapper.selectByPrimaryKey(userId);

            //去数据库sys_config表加载用户初始化默认密码，key为user.init.password
            String defaultPwd = dbLoadSysConfig.getConfigItem("user.init.password");
            sysUser.setPassword(passwordEncoder.encode(defaultPwd));


            //更新该用户密码为默认初始化密码
            sysUserMapper.updateByPrimaryKeySelective(sysUser);

            //看上去就像是本地调用smsService接口方法，实际是发送http请求调用远程服务
            smsFeignClient.send(sysUser.getPhone(), "你好，你的密码已重置" + defaultPwd);
        }
    }

    public Boolean isdefault(String username) {
        SysUserExample sysUserExample = new SysUserExample();
        sysUserExample.createCriteria().andUsernameEqualTo(username);
        List<SysUser> sysUsers = sysUserMapper.selectByExample(sysUserExample);
        //判断数据库密码是否是默认密码
        return passwordEncoder.matches(
                dbLoadSysConfig.getConfigItem("user.init.password"),
                sysUsers.get(0).getPassword());
    }

    public void changePwd(String username, String oldPass, String newPass) {
        SysUserExample sysUserExample = new SysUserExample();
        sysUserExample.createCriteria().andUsernameEqualTo(username);
        List<SysUser> sysUsers = sysUserMapper.selectByExample(sysUserExample);
        //判断旧密码是否正确
        boolean isMatch = passwordEncoder.matches(oldPass, sysUsers.get(0).getPassword());

        if (isMatch) {
            SysUser sysUser = new SysUser();
            sysUser.setId(sysUsers.get(0).getId());
            sysUser.setPassword(passwordEncoder.encode(newPass));
            sysUserMapper.updateByPrimaryKeySelective(sysUser);
        } else {
            throw new CustomException(CustomExceptionType.USER_INPUT_ERROR,
                    "原密码输入错误，请确认后重新输入！");
        }

    }

}
