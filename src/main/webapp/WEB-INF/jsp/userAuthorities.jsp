<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <security:csrfMetaTags/>
    <title>SB Admin 2 - Bootstrap Admin Theme</title>
    <!-- Bootstrap Core CSS -->
    <link href="<%=request.getContextPath()%>/frame/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- MetisMenu CSS -->
    <link href="<%=request.getContextPath()%>/frame/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
    <!-- Timeline CSS -->
    <link href="<%=request.getContextPath()%>/frame/dist/css/timeline.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="<%=request.getContextPath()%>/frame/dist/css/sb-admin-2.css" rel="stylesheet">
    <!-- Morris Charts CSS -->
    <link href="<%=request.getContextPath()%>/frame/bower_components/morrisjs/morris.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="<%=request.getContextPath()%>/frame/bower_components/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        .node circle {
            cursor: pointer;
            fill: #fff;
            stroke: steelblue;
            stroke-width: 2px;
        }

        .node text {
            font-size: 12px;
        }

        .link {
            fill: none;
            stroke: #ccc;
            stroke-width: 1.5px;
        }
    </style>
</head>
<body>
<div id="wrapper">
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">SB Admin v2.0</a>
        </div>
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                    </li>
                    <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                    </li>
                    <li class="divider"></li>
                    <li>
                        <form id="logoutForm" action="<%=request.getContextPath()%>/logout.html" method="post">
                            <security:csrfInput/>
                            <a href="javascript:void(0)" onclick="logout()"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                            <script>
                                function logout(){
                                    $("#logoutForm").submit();
                                }
                            </script>
                        </form>
                    </li>
                </ul>
            </li>
        </ul>
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li class="sidebar-search">
                        <div class="input-group custom-search-form">
                            <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </li>
                    <li>
                        <a href="index.html"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Dashboard</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <div id="userAuthTree" style="height: auto;">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- jQuery -->
<script src="<%=request.getContextPath()%>/frame/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap Core JavaScript -->
<script src="<%=request.getContextPath()%>/frame/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Metis Menu Plugin JavaScript -->
<script src="<%=request.getContextPath()%>/frame/bower_components/metisMenu/dist/metisMenu.min.js"></script>
<!-- Custom Theme JavaScript -->
<script src="<%=request.getContextPath()%>/frame/dist/js/sb-admin-2.js"></script>
<script src="<%=request.getContextPath()%>/js/d3/d3.min.js"></script>
<script>
    var width = 700;
    var height = 500;

    //边界空白
    var padding = {left: 80, right:50, top: 20, bottom: 20 };

    var svg = d3.select("#userAuthTree")
            .append("svg")
            .attr("width", width + padding.left + padding.right)
            .attr("height", height + padding.top + padding.bottom)
            .append("g")
            .attr("transform","translate("+ padding.left + "," + padding.top + ")");

    //树状图布局
    var tree = d3.layout.tree()
            .size([height, width]);

    //对角线生成器
    var diagonal = d3.svg.diagonal()
            .projection(function(d) { return [d.y, d.x]; });

    d3.json("<%=request.getContextPath()%>/user/authTree.json", function(error, root){
        //给第一个节点添加初始坐标x0和x1
        root.x0 = height / 2;
        root.y0 = 0;

        //以第一个节点为起始节点，重绘
        redraw(root);

        //重绘函数
        function redraw(source){
            /*
             （1） 计算节点和连线的位置
             */
            //应用布局，计算节点和连线
            var nodes = tree.nodes(root);
            var links = tree.links(nodes);
            //重新计算节点的y坐标
            nodes.forEach(function(d) { d.y = d.depth * 180; });

            /*
             （2） 节点的处理
             */
            //获取节点的update部分
            var nodeUpdate = svg.selectAll(".node").data(nodes, function(d){ return d.id; });
            //获取节点的enter部分
            var nodeEnter = nodeUpdate.enter();
            //获取节点的exit部分
            var nodeExit = nodeUpdate.exit();

            //1. 节点的 Enter 部分的处理办法
            var enterNodes = nodeEnter.append("g")
                    .attr("class","node")
                    .attr("transform", function(d) { return "translate(" + source.y0 + "," + source.x0 + ")"; })
                    .on("click", function(d) { toggle(d); redraw(d); });

            enterNodes.append("circle")
                    .attr("r", 0)
                    .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

            enterNodes.append("text")
                    .attr("x", function(d) { return d.children || d._children ? -14 : 14; })
                    .attr("dy", ".35em")
                    .attr("text-anchor", function(d) { return d.children || d._children ? "end" : "start"; })
                    .text(function(d) { return d.name; })
                    .style("fill-opacity", 0);


            //2. 节点的 Update 部分的处理办法
            var updateNodes = nodeUpdate.transition()
                    .duration(500)
                    .attr("transform", function(d) { return "translate(" + d.y + "," + d.x + ")"; });

            updateNodes.select("circle")
                    .attr("r", 8)
                    .style("fill", function(d) { return d._children ? "lightsteelblue" : "#fff"; });

            updateNodes.select("text")
                    .style("fill-opacity", 1);

            //3. 节点的 Exit 部分的处理办法
            var exitNodes = nodeExit.transition()
                    .duration(500)
                    .attr("transform", function(d) { return "translate(" + source.y + "," + source.x + ")"; })
                    .remove();

            exitNodes.select("circle")
                    .attr("r", 0);

            exitNodes.select("text")
                    .style("fill-opacity", 0);

            /*
             （3） 连线的处理
             */
            //获取连线的update部分
            var linkUpdate = svg.selectAll(".link")
                    .data(links, function(d){ return d.target.id; });

            //获取连线的enter部分
            var linkEnter = linkUpdate.enter();

            //获取连线的exit部分
            var linkExit = linkUpdate.exit();

            //1. 连线的 Enter 部分的处理办法
            linkEnter.insert("path",".node")
                    .attr("class", "link")
                    .attr("d", function(d) {
                        var o = {x: source.x0, y: source.y0};
                        return diagonal({source: o, target: o});
                    })
                    .transition()
                    .duration(500)
                    .attr("d", diagonal);

            //2. 连线的 Update 部分的处理办法
            linkUpdate.transition()
                    .duration(500)
                    .attr("d", diagonal);

            //3. 连线的 Exit 部分的处理办法
            linkExit.transition()
                    .duration(500)
                    .attr("d", function(d) {
                        var o = {x: source.x, y: source.y};
                        return diagonal({source: o, target: o});
                    })
                    .remove();
            /*
             （4） 将当前的节点坐标保存在变量x0、y0里，以备更新时使用
             */
            nodes.forEach(function(d) {
                d.x0 = d.x;
                d.y0 = d.y;
            });

        }

        //切换开关，d 为被点击的节点
        function toggle(d){
            if(d.children){ //如果有子节点
                d._children = d.children; //将该子节点保存到 _children
                d.children = null;  //将子节点设置为null
            }else{  //如果没有子节点
                d.children = d._children; //从 _children 取回原来的子节点
                d._children = null; //将 _children 设置为 null
            }
        }
    });
</script>
</body>
</html>