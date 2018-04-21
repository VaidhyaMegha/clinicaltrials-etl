import sys
import json
from sys import argv
from lxml import html
from lxml import etree

reload(sys)
sys.setdefaultencoding("ISO-8859-1")

with open(argv[1], 'rb') as myfile:
    data=myfile.read()

tree=html.fromstring(data.encode().strip())

# keys=tree.xpath('/html/body/table/tr/td/table[2]/tr/td[1]')
values=tree.xpath('/html/body/table/tr/td/table[2]/tr/td[2]')

# str_pair=[{etree.tostring(key).strip() : etree.tostring(value).strip()} for key, value in zip(keys, values)]
str_values=[ etree.tostring(value).replace('~', '-').strip() for value in values]


# print("~".join([argv[2], str(hash(argv[1])), 'ctri.nic.in', 'Health', 'ICMR',  json.dumps(str_pair)]))
print("~".join([argv[2], str(hash(argv[1])), 'ctri.nic.in', 'Health', 'ICMR',  "~".join(str_values)]))

