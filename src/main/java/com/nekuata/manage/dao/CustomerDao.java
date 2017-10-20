package com.nekuata.manage.dao;

import com.nekuata.manage.domain.Customer;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerDao extends JpaRepository<Customer, Long> {

    Page<Customer> findAll(Pageable pageable);

    Customer findCustomerByName(String name);
}
