package com.nekuata.manage.service;

import com.nekuata.manage.domain.Customer;
import org.springframework.data.domain.Page;

public interface CustomerService {
    Page<Customer> findAll(int page, int size);

    Long countAll();

    Customer saveOne(Customer customer);

    Customer updateOne(Customer customer);

    Customer findOne(Long id);

    void deleteOne(Long id);
}
