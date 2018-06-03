import sys
from sys import argv
from lxml import html
from lxml import etree

reload(sys)
sys.setdefaultencoding("ISO-8859-1")

with open(argv[1], 'rb') as myfile:
    data=myfile.read()

tree=html.fromstring(data.encode().strip())

values=tree.xpath('/html/body/table/tr/td/table[2]/tr/td[2]')

str_values=[ etree.tostring(value).replace('~', '-').strip() for value in values]


print("~".join([argv[2], str(hash(argv[1])), 'ctri.nic.in', 'Health', 'ICMR',  "~".join(str_values)]))