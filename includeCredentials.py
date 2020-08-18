import argparse
import re

# parse parameters
parser = argparse.ArgumentParser()
parser.add_argument(
  'file',
  type=str,
  help='file link'
)
parser.add_argument(
  '--parameters',
  type=str,
  default='',
  help='list of parameters like "name=user1 pass=pass1"'
)
args = parser.parse_args()

# prepare parameters

group_parameters = re.findall(r'(\w+)\s?=\s?(\"[^\"]*\"|\'[^\']*\'|\b\S*\b)', args.parameters)
dict_parameters = dict(group_parameters)
for key in dict_parameters:
  dict_parameters[key] = re.sub(r'(^[\'\"]|[\'\"]$)','', dict_parameters[key])

print(dict_parameters)

# repalce data in file
with open(args.file) as file_in:
    text = file_in.read()

for key in dict_parameters:
  text = re.sub('{{'+key+'}}',dict_parameters[key], text)

with open(args.file, "w") as file_out:
    file_out.write(text)