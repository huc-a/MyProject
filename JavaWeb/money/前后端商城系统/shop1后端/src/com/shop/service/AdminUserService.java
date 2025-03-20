package com.shop.service;

import java.util.List;
import com.shop.entity.AdminUser;

import com.shop.dao.AdminUserDao;

/**
 * 管理员用户业务处理类
 */
public class AdminUserService {

    // 创建数据库操作对象
    private AdminUserDao adminUserDao = new AdminUserDao();

    /**
     * 添加管理员用户
     * @param adminUser
     * @return
     */
    public int add(AdminUser adminUser) {
        return adminUserDao.add(adminUser);
    }

    /**
     * 删除管理员用户
     * @param username
     * @return
     */
    public int delete(String username) {
        return adminUserDao.delete(username);
    }

    /**
     * 更新管理员用户
     * @param adminUser
     * @return
     */
    public int update(AdminUser adminUser) {
        return adminUserDao.update(adminUser);
    }

    /**
     * 获取管理员用户
     * @return
     */
    public List<AdminUser> getAllAdminUser(String username) {
        return adminUserDao.getAllAdminUser(username);
    }

    /**
     * 根据username获取管理员用户详情
     * @param username
     * @return
     */
    public AdminUser getAdminUserByUsername(String username) {
        return adminUserDao.getAdminUserByUsername(username);
    }
}
