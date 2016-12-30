import os
import base64
import hashlib

#print base64.b64encode(hashlib.new("sha1", "myname:mypass\n").digest())
print hashlib.new("sha1", "myname:mypass").hexdigest()
