package com.nekuata.manage.service;

import com.nekuata.manage.domain.Customer;

import java.util.List;

public interface CustomerService {
    List<Customer> findAll(int page, int size);

    Long countAll();

    Customer saveOne(Customer customer);

    Customer findOne(Long id);
}
