package com.nekuata.manage.service.implement;

import com.nekuata.manage.dao.CustomerDao;
import com.nekuata.manage.domain.Customer;
import com.nekuata.manage.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
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
    public Page<Customer> findAll(int start, int length) {
//        Sort sort = new Sort(Sort.Direction.DESC,"id");
        // 分页查询
        // 当前页
        int page = start/length;
        Pageable pageable = new PageRequest(page, length, Sort.Direction.DESC,"id");
        return customerDao.findAll(pageable);
    }

    @Override
    public Long countAll() {
        return customerDao.count();
    }

    @Override
    public Customer saveOne(Customer customer) {
        // 判断用户名是否重复
        if (customerDao.findCustomerByName(customer.getName()) != null) {
            return null;
        } else {
            // 添加并立刻同步到数据库
            return customerDao.saveAndFlush(customer);
        }
    }

    @Override
    public Customer updateOne(Customer customer) {
        // 此方法也可用于更新
        return customerDao.saveAndFlush(customer);
    }

    @Override
    public Customer findOne(Long id) {
        return customerDao.findOne(id);
    }

    @Override
    public void deleteOne(Long id) {
        customerDao.delete(id);
    }
}
