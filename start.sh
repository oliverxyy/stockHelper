#!/bin/bash
#
# author:oliverxyy
# url:https://github.com/oliverxyy/stockHelper 
# license:Apache License 2.0
#
# config stocks
stocks=(
    sz000717
    sh600579
    sh600581
)
#set interval,default unit is second
interval=5 #s/m/h
stock_column_name="股票名\t当前价\t涨幅值\t涨幅比\t开盘价\t收盘价\t最高价\t最低价\t成交股w\t成交额w\t\n"
#stock_column_name="股票名\t当前价\t涨幅\t开盘价\t收盘价\t最高价\t最低价\t买一价\t卖一价\t成交股w\t成交额w\t买一股\t买一价\t买二股\t买二价\t买三股\t买三价\t卖一股\t卖一价\t卖二股\t卖二价\t卖二股\t卖二价\t卖三股\t卖三价\t当前时间\t\n"
#stock_column_name="股票名称\t开盘价\t收盘价\t当前价\t最高价\t最低价\t买一价\t卖一价\t成交股\t成交额\t买一股\t买一价\t买二股\t买二价\t买三股\t买三价\t买四股\t买四价\t买五股\t买五价20\t卖一股\t卖一价\t卖二股\t卖二价\t卖二股\t卖二价\t卖三股\t卖三价\t卖四股\t卖四价\t日期\t时间\t\n"

# use sina stock api
req="http://hq.sinajs.cn/list="
url=$(echo $req${stocks[*]}|sed 's/ /,/g')
############################################################


function printRow(){
    row=$1
    #echo "$row"|awk -F ',' '{if ( $4 < $3 ) c="\033[32m";else c="\033[31m"; printf("%-s\t\033[33m%-s\033[0m\t"c"%.2f\033[0m\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%.f\t%.f\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t%-s\t\n",$1,$4,($4-$3)/$3*100,$2,$3,$5,$6,$7,$8,$9/10000,$10/10000,$11,$12,$13,$14,$15,$16,$21,$22,$23,$24,$25,$26,$27,$28,$32)}'
    echo "$row"|awk -F ',' '{if ( $4 < $3 ) c="\033[32m";else c="\033[31m"; printf("%-s\t\033[33m%-s\033[0m\t"c"%.2f\033[0m\t"c"%.2f\033[0m\t%-s\t%-s\t%-s\t%-s\t%.f\t%.f\t\n",$1,$4,$4-$3,($4-$3)/$3*100,$2,$3,$5,$6,$9/10000,$10/10000)}'
}

function show(){
    printf $stock_column_name
    while :
    do
        rep=$(curl -s $url|iconv -f gbk -t utf8)
        OLD_IFS="$IFS"
        IFS='";'
        item=($rep)
        IFS="$OLD_IFS"
        item_length=${#item[@]} 
        i=1
        for arr_item in ${item[*]}
        do
            if [ `expr $i % 3` == 0 ]
            then
                row=$arr_item
                printRow $row
            fi
            ((i++))
        done
        sleep $interval
        printf "\n"
    done
}
show






