import binascii
import logging
import os
import time
from os.path import expanduser

import linode.api as linapi

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s %(levelname)s %(message)s')

with open("LINODE_GROUP") as f:
    GROUP = unicode(f.read().strip())

def info(key):
    client = linapi.Api(key = key, batching = False)

    print(client.avail_linodeplans())

def main():
    key = os.getenv("LINODE_API_KEY")
    try:
        with open(expanduser("~/.linode.key")) as f:
            key = str(f.read().strip())
    except:
        raise RuntimeError("please specify Linode API key")

    info(key)

if __name__ == "__main__":
    main()
