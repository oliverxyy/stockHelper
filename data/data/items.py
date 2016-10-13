# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

import scrapy


class DataItem(scrapy.Item):
    url = scrapy.Field()
    username = scrapy.Field()
    daily_earnings = scrapy.Field()
    month_earnings = scrapy.Field()
    year_earnings = scrapy.Field()
    sum_earnings = scrapy.Field()
    profit_and_Loss = scrapy.Field()
    winning_percentage = scrapy.Field()
    # hold_stock = scrapy.Field()
    pass
