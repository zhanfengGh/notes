## 	YH 工作日志

1. y5ozFhxR
2. logstash @timestamp 时区问题
3. ~~提供Pod重启 扩容 缩容 api (追@牟良 )~~
4. ~~资源依赖 , TOPN , 实例的负载均衡（参考@张超  http://skywalking.yonghuivip.com/#/monitor/service~~
5. 参考下/flow/ajax_overflow_utf8.jsp 对于指定 限流框架的异常 指定一个输出资源 b2c-platform发布一个优化
6. springcloud 接口列表 return type待优化
7. ~~ES 分批取数据优化~~
8. ~~ES filter查询~~
9. 保存用户群组时调度同步任务，调度单任务
10. 调度数据过滤时若es条件完全一致，可以优化跳过es查询使用已有结果。

##### project in progress

1. ~~member-center 灰度用户redis缓存key优化 [CRM-2063](http://jira.yonghuivip.com/browse/CRM-2063)~~ 合并到CRM-2071
1. api-rest / member-center SVIP2.0 开发 [CRM-2071](http://jira.yonghuivip.com/browse/CRM-2071)
1. web-frame 添加gender字段 [CRM-2073](http://jira.yonghuivip.com/browse/CRM-2073)



##### 上线注意事项

1. 送货地址添加gender字段
   1. flyway alter table
   1. member-center / api-rest / web-frame
1. 新版超级会员购卡支付页面
   1. config添加配置: SUPER_MEMBER / svip-member-card-version-2

##### 2019 第31周工作笔记

问题待确认

1. ~~API 版本号 5.2.0~~
2. 续费超级会员消息类型



开发记录

1. 超级会员2.0需求

   1. 添加季卡/年卡

      > ALTER TABLE `yh_super_member_operation`
      > MODIFY `card_type` TINYINT DEFAULT NULL COMMENT '卡类型：-1-老版100元/年；1-月卡; 3-季卡；12-年卡'
      >
      > todo  yh_dues_bill 也需要添加字段

   1. 收货地址添加性别字段

      > ALTER TABLE `yh_delivery_address`
      > ADD COLUMN `gender` CHAR(1) NOT NULL DEFAULT '' COMMENT 'F-female；M-male；空字符-未定义' AFTER `name`

   1. 现有支付发起接口不能满足

      > prePayDues 

   1. payDues

      > Erp 消息新版超级会员添加新的消息类型/分开卡类型

1. 开发规划

   1. 会员中心接口适配2天 2019-07-31～2019-08-01
      1. 老超级会员添加到灰度用户中
      1. member-center 添加新接口，查询购买的会员卡历史信息
   1. 支付预订单/支付完成接口适配2天 2019-08-02～2019-08-05 
      1. 预支付页面添加卡片适配
      1. 支付成功后，db适配
   1. 灰度用户判断人群id接口包装1天 2019-08-06
   1. ju
   
1. 开发记录

   1. AssetInfoRep 添加 svipUser/oldSuperUser/svipRightsList 等字段
   1. 地址加性别
   1. 专属客服
   
1. 支付 定义找产品确认

   1.  /buycardinfo

      1. ? 昵称用哪个字段

      ```json
      {
      	"banimg":"ddd",
        "userInfo":{
          "logo":"",
          "mobile": "",
          "isSuper": true,
          "wasSuper": true,
          "issueDate": "",
          "expireDate": ""
        },
      	"svipCards":[
      		{
      			"type":3,
      			"title":"季卡90天",
      			"amount":4500,
      			"desc": "¥15/月",
      			"discount": "72折",
      			"specialPrice": false
      		},
      		{
      			"type":1,
      			"title":"月卡30天",
      			"amount":990,
      			"desc": "¥18/月",
      			"discount": "",
      			"specialPrice": true
      		}
      	]
      }
      ```

   1. /buycard/prepay

   1. //buycard

      请求中多加一个type参数

   



##### 2019 第30周工作笔记

1. CRM可视化平台发版
   1. ~~tag-manage-center crm-2053 crm产品需求优化（过滤门店为0的城市/用户群组详情cache）~~
   1. ~~tag-usage-center crm-2030 文件上传容错处理~~
   1. ~~tag-collect-center crm-2057 hbase to es 数据同步异常告警~~
   1. 

##### 2019 第29周工作笔记

1. 超级会员7.22上线准备
1. ~~营销坑位上线支持~~
1. 数据同步异常告警 定时任务
1. 

##### 2019  第28周工作笔记

1. ~~会员中心 入口1/入口2/入口3 跳转的落地页的url~~
1. ~~支付页面 超级会员条款url~~
1. 超级会员灰度场景的开始时间/结束时间给一下

3 件事

1. member-center百佳积分已完成 http://jira.yonghuivip.com/browse/CRM-2041

1. api-rest 人中心接口添加营销活动坑位查询适配已完成 http://jira.yonghuivip.com/browse/BAC-18170

   > 已合并到pre-develop分支，所以stage环境是好的，其他环境为止

1. OP 极验2.0 升级 http://jira.yonghuivip.com/browse/BAC-18211

   thirdparty-center 已添加适配；risk-center/api-rest还未添加相应适配

   > RSA 加密未完成
   >
   > 未编写单元测试



1. sort -n  sheet0.txt sheet1.txt 刷单mobile.txt > mobile_all.txt 
1.  上线member-center
   1. ~~flyway 线上建表~~
   1. 灰度用户DB导入
   1. ~~灰度场景线上配置~~
1. 上线api-rest
  
   1. ~~老会员iconUrl 由固定->配置~~
   
      - API_REST_ASSET / member-rights-icon-url
   
        > https://image.yonghuivip.com/icon_give_coupon@3x.png
   
   1. ~~老会员跳转url不变。代码里做了兼容，若不更新，则不要配置。~~
   
      1. API_REST_ASSET / member-rights-none-paid 新增配置
   
         > 不更新不要配置
   
      1. API_REST_ASSET / member-rights-renew 新增配置
   
         > 不更新不要配置
   
   1. ~~新会员iconUrl 新建配置~~
   
      - API_REST_ASSET / super-member-rights-icon-url
   
        > https://image.yonghuivip.com/jinBi_3x.png
   
      - API_REST_ASSET / super-member-rights-backimg-url
   
        > https://image.yonghuivip.com/BG_3x.png
   
   1. ~~新会员跳转url 新建配置~~
   
      跳转到超级会员落地页
   
      - API_REST_ASSET / super-member-rights-jump-url 入口2/入口3
   
      - API_REST_ASSET/member-grade-desc-url-g-0  入口1
   
      - API_REST_ASSET/member-grade-desc-url-g-1  入口1
   
        > myyh://yhlife.com/show/web?url=https%3a%2f%2factivity.yonghuivip.com%2fh5%2fyh-activity%2fsuper_member%2findex.html%3fngbcolor%3d342F35%3fsupermember%3d1%26ngbcolor%3d342F35
        >
        > https://activity.yonghuivip.com/h5/yh-activity/super_member/index.html?ngbcolor=342F35?supermember=1&ngbcolor=342F35
   
   1. ~~支付页面配置中心~~
   
      - 支付信息会员卡信息:   MEMBER-ASSET/svip-member-card-info (abandoned)
   
      - 支付信息会员卡信息:   SUPER_MEMBER/svip-member-card-info
   
        ```json
        [
        	{
        		"type": 1,
        		"amount":18,
        		"amountDesc":"元/月",
           	"banimg": "https://image.yonghuivip.com/privilege.png",
            "descimg": "",
            "termsUrl": "myyh://yhlife.com/show/web?url=https%3a%2f%2factivity.yonghuivip.com%2fh5%2fyh-activity%2fsuper_member%2fclause.html"
        	}
        ]
        ```
   
   1. ~~灰度场景配置~~
   
      > 1h 缓存，需提前1h更改
   
      - groupId: MEMBER
      - dataId: YH_GRAY_SCENE_DEFINE (abandoned)
      - dataId: yh-gray-scene-define-info
   
      ```json
      [
      	{
      		"sceneCode": "SVIP_GRAY_18",
      		"start": 1563724800000,
      		"startStr": "2019-07-22 00:00:00",
      		"end": 1624773573000,
      		"endStr":"2021-06-27 13:59:33"
      	}
      ]
      
      ```
   
      ```
      // just for test
      [
      	{
      		"sceneCode": "SVIP_GRAY_18",
      		"start": 1562824800000,
      		"startStr": "2019-07-11 14:00:00",
      		"end": 1563033600000,
      		"endStr":"2019-07-14 00:00:00"
      	}
      ]
      ```

##### 2019 第27周工作笔记

1. 限时抢购页面要显示黑色 (赵飞)
1. 改动接口
   1. http://api-stage.yonghuivip.com/api/asset/info 会员中心信息
   1. https://api-stage.yonghuivip.com/api/asset/buycardinfo 会员卡支付页面
   1. https://api-stage.yonghuivip.com/api/asset/buycard 购买接口
1. ~~会员权益 url更改~~
1. ~~入口2图配置~~
1. 

##### 2019 第26周工作笔记

1. IOS zhaojunyu/Android kuangxiaomin

1. 超级会员购买期配置

   1. @薛佳乐配置，我方仅读取
   
   - SUPER_MEMBER/trail-operation-date
   
1. 会员中心页面中间入口2新老会员跳转及图标配置

   1. 老会员iconUrl 由固定->配置
     
      - API_REST_ASSET / member-rights-icon-url
      
        > https://image.yonghuivip.com/icon_give_coupon@3x.png
      
   1. 老会员跳转url不变

      1. API_REST_ASSET / member-rights-none-paid 新增配置

         > 生产环境：myyh://yhlife.com/show/native?name=activitypage&id=5acf2ec16e72cb08d5b37090
         >
         > stage环境：myyh://yhlife.com/show/native?name=activitypage&id=5d1da2670864b1ae474c05bc

      1. API_REST_ASSET / member-rights-renew 新增配置

         > 生产环境：myyh://yhlife.com/show/native?name=activitypage&id=5acf2f061e3b557ad7216a42
         >
         > stage环境：myyh://yhlife.com/show/native?name=activitypage&id=	

   1. 新会员iconUrl 新建配置
     
      - API_REST_ASSET / super-member-rights-icon-url
      
        > https://image.yonghuivip.com/jinBi_3x.png
      
      - API_REST_ASSET / super-member-rights-backimg-url
      
        > https://image.yonghuivip.com/BG_3x.png
      
   1. 新会员跳转url 新建配置
     
      1. 跳转到超级会员落地页
      
      - API_REST_ASSET / super-member-rights-jump-url
      
        >  myyh://yhlife.com/show/web?url=http%3a%2f%2ftest-activity.yonghuivip.com%2fnewstage%2fh5%2fyh-activity%2fsuper_member%2findex.html%3fsupermember%3d1%26ngbcolor%3d342F35
        >
        >  http://test-activity.yonghuivip.com/newstage/h5/yh-activity/super_member/index.html?supermember=1&ngbcolor=342F35

1. 新超级会员点击会员图标跳转地址配置

   1. ~~跳转到同一个地址？~~ 产品已确认
   2. 跳转到入口2相同的地址

   - 灰度用户非新版超级会员: API_REST_ASSET/member-grade-desc-url-g-0  

     > myyh://yhlife.com/show/web?url=http%3a%2f%2ftest-activity.yonghuivip.com%2fnewstage%2fh5%2fyh-activity%2fsuper_member%2findex.html%3fsupermember%3d1%26ngbcolor%3d342F35
     >
     > http://test-activity.yonghuivip.com/newstage/h5/yh-activity/super_member/index.html?supermember=1&ngbcolor=342F35

   - 灰度用户新版超级会员:     API_REST_ASSET/member-grade-desc-url-g-1

     > myyh://yhlife.com/show/web?url=http%3a%2f%2ftest-activity.yonghuivip.com%2fnewstage%2fh5%2fyh-activity%2fsuper_member%2findex.html%3fsupermember%3d1%26ngbcolor%3d342F35
     >
     > http://test-activity.yonghuivip.com/newstage/h5/yh-activity/super_member/index.html?supermember=1&ngbcolor=342F35

1. 会员权益跳转同入口2的一致

   > API_REST_ASSET / super-member-rights-jump-url

1. 支付页面配置中心grouId/dataId

   - 支付信息会员卡信息:   MEMBER-ASSET/svip-member-card-info

   - 支付信息会员卡信息:   SUPER_MEMBER/svip-member-card-info

     ```json
     [
     	{
     		"type": 1,
     		"amount":1800,
     		"amountDesc":"月",
        	"banimg": "",
         "descimg": "",
         "termsUrl": "https://www.baidu.com"
     	},
       {
     		"type": 3,
     		"amount":5400,
     		"amountDesc":"季度",
         "banimg": "https://www.baidu.com",
         "descimg": "",
         "termsUrl": "https://www.baidu.com"
     	}
     ]
     ```

1. 灰度场景配置

   - groupId: MEMBER
   - dataId: YH_GRAY_SCENE_DEFINE
   - dataId: yh-gray-scene-define-info

   ```json
   [
   	{
   		"sceneCode": "SVIP_GRAY_18",
   		"start": 1561447277000,
   		"startStr": "2019-06-25 15:21:17",
   		"end": 1624773573000,
   		"endStr":"2021-06-27 13:59:33"
   	}
   ]
   ```

   1. SVIP_GRAY_18:    代表18元一个月新超级会员

   2. SVIP_GRAY_18:    result=experiment 实验组/ result=contrast 对照组

1. ~~会员中心 超级会员gradeId=1~~

1. ~~超级会员灰度时间怎么定~~ 2years

1. ~~超级用户退款问题~~

  1. 退款发起时已不是灰度用户
  1. 超级会员目前只有一个月，不存在3个月后还需要退款的情况
  
   

##### 2019 第25周工作笔记

4596

a0e66bcfe67fd678b9d4d039737af2eb

8485c36fb145c588cae49d818c2468f2

##### 2019 第24周工作笔记

1. 灰度用户查询
   1. 灰度sense_code配置（开始/结束时间）
   2. 灰度用户表（code+memberId）唯一索引，接口查询时加缓存
   3. 结果isGray(code是否命中)+result
2. 是否超级会员接口加缓存
3. 
   crm可视化平台 需求分析/db设计/restful接口开发/前端接口文档/单元测试/集成测试辅助（数据不足时，添加辅助测试代码，以降低环境问题对整体项目进度的影响）/上线数据库初始化/页面权限配置
4. 团队合作精神/代码不仅仅做到可用，还要优化到极致/追求产出/乐于学习
5. 根据业务场景选择最合适的技术解决方案（ES filer/ES page）
6. 

##### 2019 第23周工作笔记

1. ~~todo ES查询语句生成: CityGenerator/ShopGenerator 把测试的去掉~~
2. ~~check online db data~~
4. ~~资源权限online数据库导入~~

##### 2019 第22周工作笔记

1. ~~用户群组分页数据/详情页数据 新增 editable(是否可编辑) 字段/ 根据当前用户校验是否有导出权限~~
2. ~~todo权限接口~~
3. ~~cityId -> cityCode 关系添加到redis缓存中~~
4. ~~保存用户群组时同步一次ES数据过滤~~
5. ~~用户群组分页数据中添加ES过滤状态~~
6. ~~测试 新用户培育 es 查询条件~~

##### 2019 第21周工作笔记：

1. ~~**tag-manage-center API 权限太大 需改小点**~~
2. ~~todo 上传/下载/主任权限/tag-usage-center数据过滤~~
3. todo 

```
{
  "sellerId":14,
  "cityList"[
  	{
  		"id":4,
  		"name":"福州"
  	},
  	{
  		"id":5,
  		"name":"郑州"
  	}
  ]
}
```



```
{
	"total":33280,
	"pageSize":10,
	"pageNo":1,
	"data":[
		{
      "id": 3,
      "code": "mg:3",
      "level12":"永辉到家_用户运营",
      "name": "level3_新建用户群组名字",
      "disableStatus":false, 
      "count": 18888, // 字段有可能缺失，表示还没有数据
      "countUpdatedAt":"2019-05-12 12:00",// 字段有可能缺失，表示还没有数据
      "resultFilePath":"xxxxxxx",// 字段有可能缺失，表示还没有数据
      "updatedAt":"2019-05-12 12:00",
      "createdBy":"王大治",
      "createdAt":"2019-05-12 12:00",
		},
		{
      "id": 3,
      "code": "mg:3",
      "level12":"永辉到家_用户运营",
      "name": "level3_新建用户群组名字",
      "disableStatus":false, 
      "count": 18888, // 字段有可能缺失，表示还没有数据
      "countUpdatedAt":"2019-05-12 12:00",// 字段有可能缺失，表示还没有数据
      "resultFilePath":"xxxxxxx",// 字段有可能缺失，表示还没有数据
      "updatedAt":"2019-05-12 12:00",
      "createdBy":"王大治",
      "createdAt":"2019-05-12 12:00",
		}
	]
}
```



##### 2019 第20周工作笔记：

1. 城市/门店标签如何存储？

```json
{
    "id": 555,
    "code": "555",
    "name": "用户群组名字",
    "remark": "备注",
    "level3": {
        "code": "55",
        "name": "新用户培育"
    },
    "selectedTags": [
        {
            "tagCode": "front_city_id",
            "tagValueType": 0,
            "tagValue": "城市id以英文半角逗号分隔/全选城市以*表示"
        },
        {
            "tagCode": "front_shop_id",
            "tagValueType": 0,
            "tagValue": "门店id以英文半角逗号分隔/全选门店以*表示"
        },
        {
            "tagCode": "55",
            "tagValueType": 1,
            "tagValue": "50"
        },
        {
            "tagCode": "55",
            "tagValueType": 0,
            "tagValue": "1,2,3,4,5"
        }
    ]
}
```



##### 2019 第19周工作笔记：

1. todo
1. 标签分组挂在会员群组的二级分类下？ 标签和会员群组分类没有关系，标签之间会有一个内部分组聚合
1. @OpenAPI?配置权限
1. dao层sql自己写/自动生成？
1. 会员群组管理权限
1. 更新redis缓存时有必要加锁么？
1. tag-usage-center 读取io次数太多



1. 一个sku什么时候会有多个settlement？
1. earn_bill 进出平衡问题
1. 消费积分的订单会产生新的积分？
1. 评价产生通用积分会被分摊到各个店铺/玩游戏消费通用积分但是没有退还个店铺（出入不平衡）
1. 根据事件id退积分时，结算对象并没有更新

##### 2019 第18周工作笔记：

1. credit 中消息的作用
1. 消费积分时，如何计算，订单中每个商品使用多少积分，有上游计算好传下来？

##### 2019 第17周工作笔记：

1. 下单产生积分/基于事件撤销积分
   1. mysql写操作加事务/读操作不加事务？
1. @牟良 实例数接口/实例操作回调
1. sentinel 定制需求改造
   1. yh-custom-sentinel develop -> master // TODO
   1. yh-sentinel-parent发布1.2.0 // TODO
   1. atlantis-web 发布测试 // TODO
1. hystrix 
   1. Latency and Fault Tolerance
   1. stop cascading failures. Fallbacks and graceful degradation. Fail fast and rapid recovery.
   1. threads and semaphore isolation with circuit breaker
   1. realtime monitoring and configuration changes // 实时监控和配置更新 ?how
1.  

##### 2019 第16周工作笔记：

1. 熔断技术预研
   1. sentinel
   1. hytrix
   1. 第三方
2. sentinel
   1. 接入点：C端。在C端对流量做统计
   2. 生态dubbo adapter/feign/@SentinelResource
   3. 依赖@SentinelResource可在出口流量做2个维度的安全策略：1-限制依赖服务的线程数（FlowControl）；2-服务降级熔断（DegradeControl）失败时均可回调降级逻辑
      1. dubbo 在发生限流/熔断时，若没有提供具体的callback，可以设置统一的callback逻辑。
      2. sc Feign 开箱即用集成
   4. 降级熔断策略：rt/exception_radio/exception count

##### 2019 第15周工作笔记：

1. 0.5 更改POST 请求的x-www-form-urlencoded 为binary  (application/json)
1. /v1/sentinel_rules/application/config 流控配置-应⽤级别状态变更
1. ~~实例操作联调~~
1. ~~mybatis sql 日志~~
1. ~~@liqi @wangchao 实例管理日志搜索~~
1. ~~本地连接t1环境，consul中无信息~~

##### 2019 第14周工作笔记：服务治理接口

1. 重构ES查询接口，支持跨天历史等长数据查询(用时：1天)

1. 添加dubbo/http测试接口（用时：0.5天）

1. 补加/v1/sentinel_rules/application/flow 流控配置-应⽤级别查询

1. 补加/v1/sentinel_rules/application/flow/{appName} 流控配置-接⼝级别列表查询

1. /v1/instance_manage/application/info 实例管理-添加-应⽤级别信息

   list=[{"appName":"atlantis-web"},{}]

1. /v1/instance_manage/application/instances 实例管理-基础信息

1. /v1/instance_manage/application/operate 实例管理-执⾏任务

1. /v1/instance_manage/application/operate/log 实例管理-任务列表分⻚

##### 2019 第13周工作笔记： 服务治理平台接口详细梳理

> 接口监控指标需要从DB从获取数据第14周@张超询问详情

1. /v1/service_governance/services/names 应⽤列表-查询
1. /v1/sentinel/monitor/http/history 接⼝流控监控-历史查询
1. /v1/sentinel/monitor/dubbo/history
1. /v1/interface_monitor/flow/dubbo 接⼝流控，熔断监控指标-实时查询
1. /v1/interface_monitor/flow/http
1. 添加限流规则com.yonghui.partner.api.PartnerService:listOrders(com.yonghui.partner.api.model.order.OrdersQueryParams)
1. 部署打通t1环境

##### 2019 第12周工作笔记：服务治理平台接口详细梳理

1. > ? 无法根据feature来看限流日志
   >
   > ? 日志是根据rn聚合的（不能区分feature）

1. ~~dubbo 服务列表注册到zk中，缺少清理~~

1. ~~服务列表（怎么表示）~~

1. 服务监控/实例管理数据在哪

1. 接口监控详解

1. 流控

   > todo 无法配置应用级别开关（流控/日志）
   >
   > todo 无法按应用展示流控规则
   >
   > todo 无手动添加页面

1. 接口实现

   1. /v1/service_governance/rest/services 获取所有应用列表
   1. /v1/service_governance/dubbo/services 获取所有应用列表
   1. 
   1. /v1/service_governance/dubbo/interfaces  Dubbo接⼝列表-查询
   1. /v1/service_governance/rest/interfaces 
   1. 
   1. /v1/service_governance/dubbo/interfaces/{servicesName} Dubbo接⼝列表-应⽤级别查询
   1. /v1/service_governance/rest/interfaces/{servicesName} 
   1. 
   1. /v1/sentinel_rules/check/dubbo 接⼝流控配置-查询是否存在配置
   1. /v1/sentinel_rules/check/http
   1. /v1/sentinel_rules/new/dubbo 接⼝流控配置-新增
   1. /v1/sentinel_rules/new/http
   1. /v1/sentinel_rules/update/duboo 接⼝流控配置-更新
   1. /v1/sentinel_rules/update/http
   1. /v1/sentinel_rules/get/dubbo 接⼝流控配置-查询
   1. /v1/sentinel_rules/get/http
   1. /v1/sentinel_rules/delete/dubbo 接⼝流控配置-删除
   1. /v1/sentinel_rules/delete/http
   1. /v1/sentinel_rules/{applicationName}/config 获取应用的限流配置（限流开关/日志开关）
   1. /v1/sentinel/monitor/http 接⼝流控监控-实时查询
   1. /v1/sentinel/monitor/dubbo

##### 2019 第12周工作笔记：服务治理平台接口详细梳理

1. 服务列表（怎么表示）

1. 服务监控/实例管理数据在哪

1. 接口监控详解

1. 流控

   > todo 无法配置应用级别开关（流控/日志）
   >
   > todo 无法按应用展示流控规则
   >
   > todo 无手动添加页面



##### 2019 第11周工作笔记：

1. ~~skywalking 接口测试~~

2. ~~服务体验接口封装~~

   ```
   /v1/service_check/services
   /v1/service_check/services/{serviceId}/instance_throughput
   /v1/service_check/services/{serviceId}/topology
   /v1/service_check/services/{serviceId}/rt
   /v1/service_check/services/{serviceId}/slow_end_point
   请求参数中请携带start/end时间参数
   http://192.168.20.237:9300/v1/service_check/services/1441/instance_throughput?start=2019-03-13 16:35&end=2019-03-13 16:50
   ```

   

3. dubbo服务列表

   1. ~~优化服务列表在zk中的数据结构~~
   1. RESTFul uri



#####2019 第10周工作笔记：

1. ~~日志中环境问题~~
2. ~~http异步Client~~，可深入学习下[实现原理](https://hc.apache.org/httpcomponents-core-ga/tutorial/html/index.html)
3. ~~ES 集群模式~~
4. ~~联合测试@卢乾坤开发@李靖春调低限流阀值~~
5. Pod重启 扩容 缩容 api (追@牟良 )
6. 

#####2019 第9周事项：

1. ~~上线确认 @李靖春~~

2. ~~限流规则生成 @李靖春~~

   sentinel_rules/partner-center/config:

   ```
   {
       "flow": true,
       "logOnlyWhenBlocked": true
   }
   ```

   sentinel_rules/partner-center/flow:

   ```
   [
       {
           "resource": "com.yonghui.partner.api.PartnerService:findPartner(long,long,java.lang.String,com.yonghui.partner.api.model.developing.AddressInfo)",
           "count": 1000000
       },
       {
           "resource": "com.yonghui.partner.api.PartnerService:findPartner(long,long)",
           "count": 1000000
       },
       {
           "resource": "com.yonghui.partner.api.PartnerService:getOrder(long)",
           "count": 1000000
       },
       {
           "resource": "com.yonghui.partner.api.PartnerService:getCountOfDeliveryOrder(java.lang.Integer,com.yonghui.partner.api.model.order.PartnerOrderStatus)",
           "count": 1000000
       }
   ]
   ```

   

3. ~~日志收集 @牟良~~

4. 服务列表

5. 日志区分容器/vm   @changyuli


####本地环境搭建

vm1/vm2

cd /usr/local/spring-cloud-provider;/usr/local/jdk/bin/java -Xms32m -Xmx32m -Dcsp.sentinel.log.dir=/usr/local/spring-cloud-provider/logs -jar spring-cloud-provider.jar &>/dev/null &