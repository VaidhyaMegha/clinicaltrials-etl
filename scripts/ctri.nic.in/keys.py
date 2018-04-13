import json
import collections

kv = json.load(open('./ctri.nic.in/replace_keys.json'), object_pairs_hook=collections.OrderedDict) # define desired replacements here

print("S3FilePath~FileGUID~Source~Sector~Organization~" + "~".join(kv.keys()))