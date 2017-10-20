package com.nekuata.manage.service.implement;

import com.nekuata.manage.dao.UserDao;
import com.nekuata.manage.domain.User;
import com.nekuata.manage.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * ━━━━━━神兽出没━━━━━━
 *      ┏┓   ┏┓
 *     ┏┛┻━━━┛┻┓
 *     ┃       ┃
 *     ┃   ━   ┃
 *     ┃ ┳┛ ┗┳ ┃
 *     ┃       ┃
 *     ┃   ┻   ┃ Created by nekuata.
 *     ┃       ┃
 *     ┗━┓   ┏━┛ Code is far away from bug with
 *       ┃   ┃   the alpaca protecting.
 *       ┃   ┃   神兽保佑,代码无bug.💊💊💊
 *       ┃   ┗━━━┓
 *       ┃       ┣┓
 *       ┃       ┏┛
 *       ┗┓┓┏━┳┓┏┛
 *        ┃┫┫ ┃┫┫
 *        ┗┻┛ ┗┻┛
 *
 * ━━━━━━感觉萌萌哒━━━━━━
 */

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public User findUserByUserName(String userName) {
        User realUser = userDao.findUserByUserName(userName);
        return realUser;
    }

    @Override
    public User insertUser(User user) {
        User realUser = null;
        if (user != null) {
            realUser = userDao.save(user);
        }
        return realUser;
    }
}
