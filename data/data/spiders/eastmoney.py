# -*- coding: utf-8 -*-
import scrapy
from scrapy.contrib.spiders import CrawlSpider, Rule
from scrapy.contrib.linkextractors import LinkExtractor
from data.items import DataItem


class EastmoneySpider(scrapy.Spider):
    name = "eastmoney"
    allowed_domains = ["group.eastmoney.com"]
    start_urls = (
        'http://group.eastmoney.com/index.html',
    )
    rules = [Rule(LinkExtractor(allow=['/dt,\d+.+']), 'parse')]

    def parse(self, response):
        torrent = DataItem()
        torrent['url'] = response.url
        torrent['username'] = response.xpath("//div[@class='portfolioitem-title-t']//span[@id='zuhe-name']").extract()
        #torrent['daily_earnings'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        #torrent['month_earnings'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        #torrent['year_earnings'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        #torrent['sum_earnings'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        #torrent['profit_and_Loss'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        #torrent['winning_percentage'] = response.xpath("//div[@class='portfolioitem-box box1']/span[@id='zuhe-name']").extract()
        '''for sel in response.xpath('//ul/li'):
            title = sel.xpath('a/text()').extract()
            link = sel.xpath('a/@href').extract()
            desc = sel.xpath('text()').extract()
            print title, link, desc
        '''
        return torrent
