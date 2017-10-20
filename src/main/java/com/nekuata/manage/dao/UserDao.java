package com.nekuata.manage.dao;

import com.nekuata.manage.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserDao extends JpaRepository<User, Long> {
    User findUserByUserName(String userName);
}
