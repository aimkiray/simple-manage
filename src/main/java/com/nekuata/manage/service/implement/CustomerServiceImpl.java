package com.nekuata.manage.service.implement;

import com.nekuata.manage.dao.CustomerDao;
import com.nekuata.manage.domain.Customer;
import com.nekuata.manage.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Override
    @ResponseBody
    public List<Customer> findAll(int start, int length) {
        Sort sort = new Sort(Sort.Direction.DESC, "id");
        // 分页查询
        Pageable pageable = new PageRequest(start/length + 1, length, sort);
        List<Customer> customers = (List<Customer>) customerDao.findAll(pageable);
        return customers;
    }

    @Override
    public Long countAll() {
        return customerDao.count();
    }

    @Override
    public Customer saveOne(Customer customer) {
        // 添加并立刻同步到数据库
        // 此方法也可用于更新
        return customerDao.saveAndFlush(customer);
    }

    @Override
    public Customer findOne(Long id) {
        return customerDao.findOne(id);
    }
}
