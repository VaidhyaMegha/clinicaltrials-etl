import json
import collections

kv = json.load(open('keys.json'), object_pairs_hook=collections.OrderedDict) # define desired replacements here

print("s3_file_path~file_guid~source~sector~organization~" + "~".join(kv.keys()))