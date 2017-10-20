package com.nekuata.manage.controller;

import com.nekuata.manage.domain.Customer;
import com.nekuata.manage.service.CustomerService;
import com.nekuata.manage.utils.DataTables;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@Controller
@RequestMapping
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    //    转到客户列表界面
    @RequestMapping("/customer/list")
    public String customerListPage() {
        return "customer/customer_list";
    }

    @RequestMapping(value = "/api/customer", method = RequestMethod.GET)
    @ResponseBody
    public DataTables customerList(Integer start, Integer length) {
        DataTables dataTables = new DataTables();
        // 若未传参数，则默认第一条开始查询五条
        start = start == null ? 0 : start;
        length = length == null ? 5 : length;
        Page<Customer> customers = customerService.findAll(start, length);
        dataTables.setData(customers.getContent());
        dataTables.setRecordsFiltered(customers.getTotalElements());
        dataTables.setRecordsTotal(customers.getTotalElements());
        return dataTables;
    }

    /**
     * 获取添加界面
     *
     * @return
     */
    @RequestMapping("/customer/add")
    public String showAddCustomer() {
        return "customer/customer_add";
    }

    /**
     * 执行添加操作
     *
     * @param customer
     * @return
     */
    @RequestMapping(value = "/api/customer", method = RequestMethod.POST)
    @ResponseBody
    public int addCustomer(@Valid Customer customer, BindingResult bindingResult) {
        if (!bindingResult.hasErrors()) {
            if (customer != null) {
                // 返回插入后的客户
                Customer realCustomer = customerService.saveOne(customer);
                if (realCustomer != null) {
                    return 1;
                }
            }
        }
        return 0;
    }

    //    获取修改界面
    @RequestMapping("/customer/{id}")
    public String showUpdateCustomer(ModelMap map, @PathVariable Long id) {
        Customer customer = customerService.findOne(id);
        map.addAttribute("customer", customer);
        return "customer/customer_update";
    }

    //    执行修改操作
    @RequestMapping(value = "/api/customer", method = RequestMethod.PUT)
    @ResponseBody
    public int updateCustomer(@Valid Customer customer, BindingResult bindingResult) {
        // 表单验证
        if (!bindingResult.hasErrors()) {
            if (customer != null && customer.getId() != null) {
                Customer realCustomer = customerService.updateOne(customer);
                if (realCustomer != null) {
                    return 1;
                }
            }
        }
        return 0;
    }

    @RequestMapping(value = "/api/customer/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public int deleteCustomer(@PathVariable Long id) {
        customerService.deleteOne(id);
        return 1;
    }
}
