		@page {
            size:portrait;
        }
        
        .tb{
            -webkit-column-break-inside: avoid;
            -moz-column-break-inside: avoid;
            column-break-inside: avoid;
            display: inline-block;
        }
            
        body{
            font-size:12px;
            font-family: arial;
        }
        
        .titre2{
            font-size:14px;
            text-decoration: underline;
            font-weight:bold;
            margin-bottom:5px;
        }
    
        table {
            table-layout: fixed;
        }
    
        th{
            background-color: #585858;
            color: white;
        }
        
        .blue{ 
            background-color: #D8D8D8;
            text-align: center;
            height:25px;
        }
    
    
        .header {
            text-align: center;
            height:30px;
        }
    
        .col1{
            width: 150px;
            text-align: right;
            font-weight: bold;
            vertical-align: top;
            padding-bottom:5px;
        }
        
        .col2{
            vertical-align: top;
        }
        
        .col3{
            width: 120px;
            text-align: right;
            font-weight: bold;
            vertical-align: top;
            padding-bottom:5px;
        }
        
        .col4{
            width: 200px; 
            vertical-align: top;
        }
        
        .row1{
            border-bottom: 1px solid #ADB3B2;
        }
        
        .row2{
            border-bottom: 1px solid #ADB3B2;
        }
        
        .totaux td{
            padding:2px;
            border-right:1px solid black;
            border-bottom:1px solid black;
        }
        
        .totaux {
            margin:15px 0 15px 0;
            border-top:1px solid black;
            border-left:1px solid black;
        }
        
        .lineTotaux{
            background-color:#F2F2F2;
        }
        
        .headerTotaux{
            background-color:#D8D8D8;
        }
        
        .headerTitre{
             text-align:center;
             height:50px;
             width:100%;
             border:1px solid black;
             font-weight:bold;
             font-size:14px;
             margin-bottom:15px;
        }
        
        .headerSousTitre{
             text-align:center;
             height:50px;
             width:100%;
             font-weight:bold;
             font-size:14px;
        }
        
        .depense{
            margin:5px;
            border-left:1px solid #424242;
            border-top:1px solid #424242;
        }
        
        .depense td{
            border-right:1px solid #424242;
            border-bottom:1px solid #424242;
        }
        
        .depenseLine{
            background-color: #F2F2F2;
        }
        
        .depenseHeader{
            background-color: #ADB3B2 !important;
        }