package com.yipeng.bill.bms.web;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.sun.corba.se.impl.protocol.giopmsgheaders.RequestMessage;
import com.yipeng.bill.bms.core.model.Page;
import com.yipeng.bill.bms.core.model.ResultMessage;
import com.yipeng.bill.bms.core.utils.DateUtils;
import com.yipeng.bill.bms.dao.BillCostMapper;
import com.yipeng.bill.bms.dao.BillMapper;
import com.yipeng.bill.bms.dao.BillPriceMapper;
import com.yipeng.bill.bms.dao.UserMapper;
import com.yipeng.bill.bms.domain.*;
import com.yipeng.bill.bms.model.BillPriceDetails;
import com.yipeng.bill.bms.service.BillService;
import com.yipeng.bill.bms.service.UserService;
import com.yipeng.bill.bms.vo.BillDetails;
import com.yipeng.bill.bms.vo.LoginUser;
import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import org.springframework.ui.Model;
import sun.misc.Request;
import sun.rmi.runtime.Log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.*;

/**
 * Created by Administrator on 2017/3/10.
 */
@Controller
@RequestMapping(value = "/bill")
public class BillController extends BaseController {
    @Autowired
    private BillService billService;
    @Autowired
    private UserService userService;


    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 上下层
     * @param model
     * @param way
     * @return
     */
    @RequestMapping(value = "/list")
    public  String listDetails(ModelMap model,@RequestParam(defaultValue = "1") String way)
    {
        Map<String, Object> bms = new HashMap<>();
        LoginUser user = this.getCurrentAccount();
        bms.put("user", user);
        //type 1代表 查询上游的订单   2代表 查询提交到下游的订单
        model.put("way",way);
            List<User> userList=  userService.getSearchUser(user,way);
            model.put("userList",userList);
             model.addAttribute("bmsModel", bms);

        return "/bill/billList";
    }
    /**
     * 客户页面（渠道商和代理商 ）
     * @param request
     * @return
     */
    @RequestMapping(value = "/billCustomer")
    public  String billCustomer(HttpServletRequest request,ModelMap modelMap)
    {
         User user=this.getCurrentAccount();
         Map<String,Long> params=new HashMap<>();
         //查询当前登录对象对应的客户
         params.put("createId",user.getId());
         List<User> userList=userService.userCreater(params);
        modelMap.put("userList",userList);
        return "/bill/billCustomer";
    }

    /**
     * 关键词优化
     * @param request
     * @return
     */
    @RequestMapping(value = "/billOptimization")
    public  String billOptimization(HttpServletRequest request)
    {

        return "/bill/billOptimization";
    }

    /**
     * 关键词优化列表获取
     * @param limit
     * @param offset
     * @param way
     * @param website
     * @param state
     * @return
     */
    @RequestMapping(value = "/getBillOptimization")
    @ResponseBody
    public Map<String,Object> getBillOptimization( int limit, int offset,int way,String website,int state)
    {

        offset=(offset-1)*limit;
        // Page<Bill> page = this.getPageRequest();    //分页对象
        Map<String, Object> params = this.getSearchRequest(); //查询参数
        LoginUser user=this.getCurrentAccount();
        params.put("limit",limit);
        params.put("offset",offset);
        params.put("way",way);
        params.put("userName",website);
        params.put("state",state);
        Map<String, Object> modelMap=billService.getBillDetails(params,user);
        return  modelMap;
    }

    /**
     * 调整优化
     * @param request
     * @return
     */
    @RequestMapping(value = "/OptimizationUpdate",method = RequestMethod.POST)
    @ResponseBody
    public  ResultMessage OptimizationUpdate(HttpServletRequest request)
    {
        //getParameterMap()，获得请求参数map
        Map<String,String[]> map= request.getParameterMap();
        LoginUser user=this.getCurrentAccount();
        if(user!=null)
        {

          int a=  billService.OptimizationUpdate(map,user);
            return  this.ajaxDoneSuccess("调整成功");

        }
        else
        {
            return  this.ajaxDoneError("未登录");
        }


    }
    /**
     * 待审核订单
     * @param request
     * @return
     */
    @RequestMapping(value = "/pendingAudit")
    public  String pendingAudit(HttpServletRequest request,ModelMap model)
    {
        Map<String, Object> bms = new HashMap<>();
        LoginUser user = this.getCurrentAccount();
        if(user.hasRole("SUPER_ADMIN"))
        {
            long ret=3;
            Map<String,Long> params=new HashMap<>();
            params.put("role",ret);
            List<User> userList=userService.getUserAll(params);
            model.put("userList",userList);
        }
        bms.put("user", user);
        model.addAttribute("bmsModel", bms);
        return "/bill/billPendingAudit";
    }

    /**
     * 订单table表格获取数据
     * @param limit
     * @param offset
     * @return
     */
    @RequestMapping(value = "/getBillDetails")
    @ResponseBody
    public Map<String,Object> getBillDetails( int limit, int offset,int way,String website,String keywords,String searchName,String searchUserName, String state) throws UnsupportedEncodingException {


        offset=(offset-1)*limit;
       Map<String, Object> params = this.getSearchRequest(); //查询参数
        if(!keywords.isEmpty())
        {
            try{
                keywords = new String(keywords.getBytes("ISO-8859-1"),"utf-8");
            }
            catch (UnsupportedEncodingException e)
            {
                    e.printStackTrace();
            }
            params.put("keywords",keywords);
        }
        if(!website.isEmpty())
        {
            params.put("website",website);
        }
        if(!searchName.isEmpty())
        {
            params.put("searchName",searchName);
        }
        if(!searchUserName.isEmpty())
        {
            params.put("searchUserNameId",searchUserName);
        }
        if(!state.isEmpty())
        {
            params.put("state",state);
        }

        LoginUser user=this.getCurrentAccount();
        params.put("limit",limit);
        params.put("offset",offset);
        params.put("way",way);

        Map<String, Object> modelMap=billService.getBillDetails(params,user);
        return  modelMap;
    }

    /**
     * 客户订单table表格获取数据
     * @param limit
     * @param offset
     * @return
     */
    @RequestMapping(value = "/getCustomerBill")
    @ResponseBody
    public Map<String,Object> getCustomerBill( int limit, int offset, String website,String keywords,String searchName,String searchUserName, String state)
    {
        LoginUser user=this.getCurrentAccount();


        int way;
        if(user.hasRole("DISTRIBUTOR"))
        {
            way=3;
        }
        else
        {
            way=2;
        }


        offset=(offset-1)*limit;
        // Page<Bill> page = this.getPageRequest();    //分页对象
        Map<String, Object> params = this.getSearchRequest(); //查询参数

        if(!keywords.isEmpty())
        {
            try{
                keywords = new String(keywords.getBytes("ISO-8859-1"),"utf-8");
            }
            catch (UnsupportedEncodingException e)
            {
                e.printStackTrace();
            }
            params.put("keywords",keywords);
        }
        if(!website.isEmpty())
        {
            params.put("website",website);
        }
        if(!searchName.isEmpty())
        {
            params.put("searchName",searchName);
        }
        if(!searchUserName.isEmpty())
        {
            params.put("searchUserNameId",searchUserName);
        }
        if(!state.isEmpty())
        {
            params.put("state",state);
        }

        params.put("limit",limit);
        params.put("offset",offset);
        params.put("way",way);
        Map<String, Object> modelMap=billService.getBillDetails(params,user);
        return  modelMap;
    }
    /**
     * 待审核订单table表格获取数据
     * @param limit
     * @param offset
     * @return
     */
    @RequestMapping(value = "/pendingAuditList")
    @ResponseBody
    public Map<String,Object> pendingAuditList( int limit, int offset)
    {

        offset=(offset-1)*limit;
        Map<String, Object> params = this.getSearchRequest(); //查询参数
        LoginUser user=this.getCurrentAccount();

        params.put("limit",limit);
        params.put("offset",offset);

        Map<String, Object> modelMap=billService.pendingAuditList(params,user);
        return  modelMap;
    }
    /**
     *  相同价提交(测试)
     * @return
     */
    @RequestMapping(value = "/list/sameprice",method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage samePrice(HttpServletRequest request) {

        //getParameterMap()，获得请求参数map
        Map<String,String[]> map= request.getParameterMap();
        User user = this.getCurrentAccount();
        String errorDetails=billService.saveSameBill(map,user);
        return this.ajaxDoneSuccess(errorDetails);
    }

    /**
     * 不同价导入
     * @return
     */
    @RequestMapping(value = "/list/diffrentprice",method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage diffrentprice(HttpServletRequest request)
    {
        //getParameterMap()，获得请求参数map
        Map<String,String[]> map= request.getParameterMap();
        User user = this.getCurrentAccount();
       String  errorDetails= billService.savaDiffrentBill( map,user );

        return this.ajaxDoneSuccess("");
    }

    /**
     * 调整价格
     * @return
     */
    @RequestMapping(value = "/billList/updatePrice",method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage updatePrice( HttpServletRequest request, HttpServletResponse response)
    {
        Map<String, String[]> params= request.getParameterMap();

        User user = this.getCurrentAccount();
        int a=billService.updateBillPrice(params,user);
        return  this.ajaxDoneSuccess("");
    }

    /**
     * 渠道商审核订单
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/billList/distributorPrice",method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage distributorPrice( HttpServletRequest request, HttpServletResponse response)
    {
        Map<String, String[]> params= request.getParameterMap();

        User user = this.getCurrentAccount();
        if(user!=null)
        {
            int a=billService.distributorPrice(params,user);
            return  this.ajaxDoneSuccess("成功！");
        }
        return  this.ajaxDoneError("未登录");

    }
    /**
     * 管理员审核订单
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/billList/adminPrice",method = RequestMethod.POST)
    @ResponseBody
    public ResultMessage adminPrice( HttpServletRequest request, HttpServletResponse response)
    {
        Map<String, String[]> params= request.getParameterMap();

        User user = this.getCurrentAccount();
        if(user!=null)
        {
            int a=billService.adminPrice(params,user);
            return  this.ajaxDoneSuccess("成功！");
        }
        return  this.ajaxDoneError("未登录");

    }

    @Autowired
    private BillMapper billMapper;
    @Autowired
    private BillPriceMapper billPriceMapper;
    @Autowired
    private BillCostMapper  billCostMapper;
    //测试查排名 产生消费记录
    @RequestMapping(value = "/testpm")
    @ResponseBody
    public ResultMessage testpm()
    {


        return  this.ajaxDoneSuccess("");
    }
}
