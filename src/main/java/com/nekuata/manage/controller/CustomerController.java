package com.nekuata.manage.controller;

import com.nekuata.manage.domain.Customer;
import com.nekuata.manage.service.CustomerService;
import com.nekuata.manage.utils.DataTables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    //    转到客户列表界面
    @RequestMapping("/list")
    public String customerListPage() {
        return "customer/customer_list";
    }

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    @ResponseBody
    public DataTables customerList(Integer start, Integer length) {
        DataTables dataTables = new DataTables();
        // 若未传参数，则默认第一条开始查询五条
        start = start == null ? 0 : start;
        length = length == null ? 5 : length;
        dataTables.setData(customerService.findAll(start, length));
        Long count = customerService.countAll();
        dataTables.setRecordsFiltered(count);
        dataTables.setRecordsTotal(count);
        return dataTables;
    }

    /**
     * 获取添加界面
     *
     * @return
     */
    @RequestMapping("/add")
    public String showAddCustomer() {
        return "customer/customer_add";
    }

    /**
     * 执行添加操作
     *
     * @param customer
     * @return
     */
    @RequestMapping(value = "/", method = RequestMethod.POST)
    public int addCustomer(Customer customer) {
        int result = 0;
        if (customer != null) {
            // 返回插入后的客户
            Customer realCustomer = customerService.saveOne(customer);
            if (realCustomer != null) {
                result = 1;
            }
        }
        return result;
    }

    //    获取修改界面
    @RequestMapping(value = "/{id}")
    public String showUpdateCustomer(HttpServletRequest req, @PathVariable Long id) {
        Customer customer = customerService.findOne(id);
        req.setAttribute("manage", customer);
        return "customer/customer_update";
    }

    //    执行修改操作
    @RequestMapping(value = "/", method = RequestMethod.PUT)
    public int updateCustomer(Customer customer) {
        int result = 0;
        if (customer != null && customer.getId() != null) {
            Customer realCustomer = customerService.saveOne(customer);
            if (realCustomer != null) {
                result = 1;
            }
        }

        return result;
    }

    @RequestMapping(value = "/{customerId}", method = RequestMethod.DELETE)
    public int deleteCustomer(@PathVariable int customerId) {

        int result = 0;

        return result;
    }
}
