package com.nekuata.manage.service;

import com.nekuata.manage.domain.User;

public interface UserService {

    public User findUserByUserName(String userName);

    public User insertUser(User user);
}
