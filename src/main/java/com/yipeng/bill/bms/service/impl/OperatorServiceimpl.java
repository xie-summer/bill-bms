package com.yipeng.bill.bms.service.impl;

import com.yipeng.bill.bms.core.crypto.CryptoUtils;
import com.yipeng.bill.bms.core.model.ResultMessage;
import com.yipeng.bill.bms.core.utils.DateUtils;
import com.yipeng.bill.bms.dao.RoleMapper;
import com.yipeng.bill.bms.dao.UserMapper;
import com.yipeng.bill.bms.dao.UserRoleMapper;
import com.yipeng.bill.bms.domain.Role;
import com.yipeng.bill.bms.domain.User;
import com.yipeng.bill.bms.domain.UserRole;
import com.yipeng.bill.bms.service.OperatorService;
import com.yipeng.bill.bms.service.RoleService;
import com.yipeng.bill.bms.service.UserRoleService;
import com.yipeng.bill.bms.vo.CustomerListDetails;
import com.yipeng.bill.bms.vo.Roles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by 鱼在我这里。 on 2017/3/18.
 */
@Service
public class OperatorServiceImpl implements OperatorService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;
    @Autowired
    private RoleService roleService;
    @Autowired
    private UserRoleService userRoleService;

    @Override
    public int saveOperator(User user) {

      User user1=userMapper.selectByUserName(user.getUserName());
      if(user1!=null)
      {
          return  0;
      }
      else
      {
          user.setStatus(true);
          user.setCreateTime(new Date());
          user.setPassword(CryptoUtils.md5(user.getPassword()));
          user.setLoginCount(0);
          int num = userMapper.insert(user);
          Role role=roleService.getRoleByRoleCode(Roles.COMMISSIONER.name());

          if(role!=null)
          {
              UserRole userRole = new UserRole();
              userRole.setUserId(user.getId());
              userRole.setRoleId(role.getId());
              userRoleService.saveUserRole(userRole);
          }
          return  num;
      }






    }

    /**
     * 获取操作员列表
     * @param params
     * @return
     */
    @Override
    public Map<String, Object> getOperator(Map<String, Object> params) {

        //模型对象
        List<CustomerListDetails> customerListDetailsList=new ArrayList<>();

         List<User> userList=userMapper.getQueryUserAll(params);
        int limit=Integer.parseInt(params.get("limit").toString()) ;
        int offset=Integer.parseInt(params.get("offset").toString()) ;
        int i=(offset)*limit;
        for ( User user:userList
             ) {
            i++;
            CustomerListDetails customerListDetails=new CustomerListDetails();
            customerListDetails.setId(i);
            customerListDetails.setCustomerId(user.getId());
            customerListDetails.setUserName(user.getUserName());
            customerListDetails.setRealName(user.getRealName());
            customerListDetails.setContact(user.getContact());
            customerListDetails.setStatus(user.getStatus());
            customerListDetails.setCreateTime(DateUtils.formatDate(user.getCreateTime()));
            if(user.getLastLoginTime()!=null)
            {
                customerListDetails.setLastLoginTime(DateUtils.formatDate(user.getLastLoginTime()));
            }
            customerListDetails.setLoginCount(user.getLoginCount());
            customerListDetailsList.add(customerListDetails);





        }
        Map<String, Object> modelMap = new HashMap();
        Role role= roleMapper.selectByRoleCode("COMMISSIONER");
        int roleCount=userRoleMapper.getCount(role.getId());
        modelMap.put("total",roleCount);
        modelMap.put("rows",customerListDetailsList);

        return modelMap;

    }

    @Override
    public int updateUserState(Long userId) {
        User user=new User();
        user.setId(userId);
        user.setStatus(false);
        userMapper.updateByPrimaryKeySelective(user);
        return 1;
    }

}
