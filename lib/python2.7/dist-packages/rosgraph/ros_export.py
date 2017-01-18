#!/usr/bin/python
############################################################################
#
# CopyRight @ baidu.com 2016
#
#############################################################################
"""
export interface for carsecure

Authors: niufan
Date: 2016/07/17
"""
import os
import sys

env = os.environ.get('LD_LIBRARY_PATH') + ':/home/caros/ros/lib/'
envlist=env.split(':')
for each in envlist:
    sys.path.append(each)

import librossecureso as lib
#from rosSecureModule import init_ros_secure_export
#loadlib = ctypes.cdll.LoadLibrary
#lib = loadlib("./librossecureso.so")


def init_ros_secure():
    """
    init ros.
    return value:
    True: init successfully
    FalseL init failed
    """
    result = lib.init_ros_secure_export()
    if result == 1:
        return True
    else:
        return False


def uninit_ros_secure():
    """
    uninit ros
    return value:
    True: uninit successfully
    False: uninit failed
    """
    result = lib.uninit_ros_secure_export()
    if result == 1:
        return True
    else:
        return False


def get_sig_value(inbuf):
    """
    get_sig_value ros. pret is the tuple with
    two element (element1,element2)
    element1: inbuf string
    element2: sig of the inbuf string
    """
    mygetsig = lib.get_sig_value_export
    pret = mygetsig(inbuf)
    return pret


def encrypt_data_for_ros(in_data, ullen):
    """
    encrypt data for length ullen., pret is the tuple with
    two element (element1,element2)
    element1: ciphertext for input data
    element2: ciphertext length

    warning: asume the in_data is pure string, not the raw binary data
    if in_data contain the Null charactor , the function will truncate
    the data from the Null charactor
    """
    myfuncptr = lib.encrypt_data_for_ros_export
    pret = myfuncptr(in_data, ullen)
    return pret


def decrypt_data_for_ros(in_data, ullen):
    """
    decrypt data for length ullen. pret is the tuple with
    tow elements (element1, element2)
    element1: plaintext for input data
    element2: plaintext length

    warning: asume the in_data is pure string, not the raw binary data
    if in_data contain the Null charactor , the function will truncate
    the data from the Null charactor
    """
    myfuncptr = lib.decrypt_data_for_ros_export
    pret = myfuncptr(in_data, ullen)
    return pret


def encrypt_data_and_sign(in_data, ullen):
    """
    encrypt data for length ullen, pret is the tuple with
    three elements,(element1,element2,element3)
    element1: in_data
    element2: ciphertext and signature for input data
    element3: length of the element2a

    warning: asume the in_data is pure string, not the raw binary data
    if in_data contain the Null charactor , the function will truncate
    the data from the Null charactor
    """
    myfuncptr = lib.encrypt_data_and_sign_export
    pret = myfuncptr(in_data, ullen)
    return pret


def decrypt_data_and_unsign(in_data, ullen):
    """
    decrypt data for length ullen,and remove the signature, pret is the tuple with
    three elements,(element1,element2,element3)
    element1: in_data
    element2: plaintext for input data
    element3: length of the element2

    warning: asume the in_data is pure string, not the raw binary data
    if in_data contain the Null charactor , the function will truncate
    the data from the Null charactor
    """
    myfuncptr = lib.decrypt_data_and_unsign_export
    pret = myfuncptr(in_data, ullen)
    return pret


def encrypt_buf_and_sign(in_data, ullen, ctx):
    """
    description: encrypt data and sign data for length ullen,
    pret is the tuple with two elements,(element1,element2)
    element1: ciphertext and its signatue
    element2: length of element1
    """
    myfuncptr = lib.encrypt_buf_and_sign_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def decrypt_buf_and_unsign(in_data, ullen, ctx):
    """
    description: decrypt data and unsign data for length ullen,
    pret is the tuple with two elements,(element1,element2)
    element1: plaintext which remove the signature
    element2: length of element1
    """
    myfuncptr = lib.decrypt_buf_and_unsign_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def free_ctx(ctx):
    """
    free context for socket.
    return value:
    True: free context successfully
    False: free context failed
    """
    myfuncptr = lib.free_ctx_export
    pret = myfuncptr(ctx)
    if pret == 1:
        return True
    else:
        return False


def encrypt_buf_and_sign_for_python(in_data, ullen, ctx):
    """
    description: encrypt data and sign data export for length ullen--exclusive used for python
    pret is the tuple with two elements,(element1,element2)
    element1: ciphertext and its signatue
    element2: length of element1
    """
    myfuncptr = lib.encrypt_buf_and_sign_for_python_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def decrypt_buf_and_unsign_for_python(in_data, ullen, ctx):
    """
    description: decrypt data and unsign data for length ullen --exclusively used for python
    pret is the tuple with two elements,(element1,element2)
    element1: plaintext which remove the signature
    element2: length of element1
    """
    myfuncptr = lib.decrypt_buf_and_unsign_for_python_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def free_ctx_for_python(ctx):
    """
    description: free ctx for socket , ----exclusively used for python
    return value:
    True: free context for python successfully
    False: free context for python failed
    """
    myfuncptr = lib.free_ctx_for_python_export
    pret = myfuncptr(ctx)
    if pret == 1:
        return True
    else:
        return False
    return pret


def encrypt_buf_and_sign_for_local(in_data, ullen, ctx):
    """
    description: encrypt data and sign data export for length ullen--exclusive used for local
    pret is the tuple with two elements,(element1,element2)
    element1: ciphertext and its signatue
    element2: length of element1
    """
    myfuncptr = lib.encrypt_buf_and_sign_for_local_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def decrypt_buf_and_unsign_for_local(in_data, ullen, ctx):
    """
    description: decrypt data and unsign data for length ullen --exclusively used for local
    pret is the tuple with two elements,(element1,element2)
    element1: plaintext which remove the signature
    element2: length of element1
    """
    myfuncptr = lib.decrypt_buf_and_unsign_for_local_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def encrypt_buf_and_sign_for_selfchk(in_data, ullen, ctx):
    """
    description: encrypt data and sign data export for length ullen--exclusive used for selfchk
    pret is the tuple with two elements,(element1,element2)
    element1: ciphertext and its signatue
    element2: length of element1
    """
    myfuncptr = lib.encrypt_buf_and_sign_for_selfchk_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def decrypt_buf_and_unsign_for_selfchk(in_data, ullen, ctx):
    """
    description: decrypt data and unsign data for length ullen --exclusively used for selfchk
    pret is the tuple with two elements,(element1,element2)
    element1: plaintext which remove the signature
    element2: length of element1
    """
    myfuncptr = lib.decrypt_buf_and_unsign_for_selfchk_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def encrypt_buf_and_sign_for_remote(in_data, ullen, ctx):
    """
    description: encrypt data and sign data export for length ullen--exclusive used for remote
    pret is the tuple with two elements,(element1,element2)
    element1: ciphertext and its signatue
    element2: length of element1

    warning: this function does not work due to the C++ interface's unfunction
    """
    myfuncptr = lib.encrypt_buf_and_sign_for_remote_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def decrypt_buf_and_unsign_for_remote(in_data, ullen, ctx):
    """
    description: decrypt data and unsign data for length ullen --exclusively used for remote
    pret is the tuple with two elements,(element1,element2)
    element1: plaintext which remove the signature
    element2: length of element1
    warning: this function does not work due to the C++ interface's unfunction
    """
    myfuncptr = lib.decrypt_buf_and_unsign_for_remote_export
    pret = myfuncptr(in_data, ullen, ctx)
    return pret


def check_rules(topic, node1_name, node2_name):
    """
    description: 
    input : topic: topic name
             tlen:  topic name length
             node_name: node name
             nlen: node name length
    output: turple with two elements (element1, element2)
            element1: True:need to go through the data security protection 
                      False: pass by the data security protection
            element2: data security processing flag
    """
    myfuncptr = lib.check_rules_export
    pret = myfuncptr(topic, node1_name, node2_name)
    if pret[0] == 1:
        return True, pret[1]
    else:
        return False, pret[1]

returnCode = init_ros_secure()
print 'security sdk version: 1.3.2.13'

if __name__ == '__main__':
    returnCode = init_ros_secure()
    print 'init ros secure result = ', returnCode

    in_data = '1234567890'
    retstr = get_sig_value(in_data)
    print retstr



    print '\n--begin test encrypt_data_for_ros and decrypt_data_for_ros---'
    plaintext = '0123456789abcdef'
    ciphertextTuple = encrypt_data_for_ros(plaintext, len(plaintext))
    print 'ciphertext = ', ciphertextTuple[0]
    print 'ciphertext len  = ', ciphertextTuple[1]

    plaintextTuple = decrypt_data_for_ros(ciphertextTuple[0], ciphertextTuple[1])
    print 'decrypted text = ', plaintextTuple[0]
    print 'decrypted text len = ', plaintextTuple[1]
    print '--end test interface encrypt_data_for_ros and decrypt_data_for_ros--\n'


    print '\n--begin test interface encrypt_data_and_sign and decrypt_data_and_unsign--'
    plaintext = '0123456789abcdef'
    ciphertextTuple = encrypt_data_and_sign(plaintext, len(plaintext))
    print 'ciphertext = ', ciphertextTuple[1]
    print 'ciphertext len  = ', ciphertextTuple[2]

    plaintextTuple = decrypt_data_and_unsign(ciphertextTuple[1], ciphertextTuple[2])
    print 'decrypted text = ', plaintextTuple[1]
    print 'decrypted text len = ', plaintextTuple[2]
    print 'end test interface encrypt_data_and_sign and decrypt_data_and_unsign--\n'

    print '\n--begin test interface encrypt_buf_and_sign and decrypt_buf_and_unsign--'
    myctx1 = id('baidu ADU security 1')
    in_data_soc =  "\xb3\x00\x00\x00\x00caller=/listener44'\x00\x00\x00md5sum=992"
    in_data_soc_len = len(in_data_soc)
    encryptDataSoc = encrypt_buf_and_sign(in_data_soc, in_data_soc_len, myctx1)
    print 'encrypt tuple', encryptDataSoc
    print 'encryted data right len  = ', encryptDataSoc[1]
    print 'encrypted Data actual len= ', len(encryptDataSoc[0])

    decryptDataSoc = decrypt_buf_and_unsign(encryptDataSoc[0], encryptDataSoc[1], myctx1)
    print 'decrypt tuple', decryptDataSoc
    print 'decrypt data right len = ', decryptDataSoc[1]
    print 'decrypt data actual len ', len(decryptDataSoc[0])
    print '--end test interface encrypt_buf_and_sign and decrypt_buf_and_unsign--\n'
     
    print "\n--begin test encrypt_and decrypt buf_and_sign_for_python  -"
    myctx2 = id('baidu ADU security 2')
    in_data_soc =  "\xb3\x00\x00\x00caller=/listener44'\x00\x00\x00md5sum=992"
    in_data_soc_len = len(in_data_soc)
    encryptDataSoc = encrypt_buf_and_sign_for_python(in_data_soc, in_data_soc_len, myctx2)
    print 'encrypt tuple', encryptDataSoc
    print 'encryted data right len  = ', encryptDataSoc[1]
    print 'encrypted Data actual len= ', len(encryptDataSoc[0])

    decryptDataSoc = decrypt_buf_and_unsign_for_python(encryptDataSoc[0], encryptDataSoc[1], myctx2)
    print 'decrypt tuple', decryptDataSoc
    print 'decrypt data right len = ', decryptDataSoc[1]
    print 'decrypt data actual len ', len(decryptDataSoc[0])

    print "\n--begin test  encrypt_and decrypt buf_and_sign_for_local --"
    myctx3 = id('baidu ADU security 3')
    in_data_soc =  "\xb3\x00\x00\x00allerid=/listener_116\x00\x00md5sum=992"
    in_data_soc_len = len(in_data_soc)
    encryptDataSoc = encrypt_buf_and_sign_for_local(in_data_soc, in_data_soc_len, myctx3)
    print 'encrypt tuple', encryptDataSoc
    print 'encryted data right len  = ', encryptDataSoc[1]
    print 'encrypted Data actual len= ', len(encryptDataSoc[0])
    decryptDataSoc = decrypt_buf_and_unsign_for_local(encryptDataSoc[0], encryptDataSoc[1], myctx3)
    print 'decrypt tuple', decryptDataSoc
    print 'decrypt data right len = ', decryptDataSoc[1]
    print 'decrypt data actual len ', len(decryptDataSoc[0])
    print '--end test encrypt_buf_and_sign_for_local and decrypt_buf_and_unsign_for_local--\n'

    print "\n--begin test encrypt_decrypt buf_and_sign_for_selfchk --"
    myctx4 = id('baidu ADU security 4')
    in_data_soc =  "\xb3\x00\x00\00callerid=/listener'\x00\x00\x00md5sum=992"
    in_data_soc_len = len(in_data_soc)
    enDataSoc = encrypt_buf_and_sign_for_selfchk(in_data_soc, in_data_soc_len, myctx4)
    print 'encrypt tuple', encryptDataSoc
    print 'encryted data right len  = ', enDataSoc[1]
    print 'encrypted Data actual len= ', len(enDataSoc[0])
    decryptDataSoc = decrypt_buf_and_unsign_for_selfchk(enDataSoc[0], enDataSoc[1], myctx4)
    print 'decrypt tuple', decryptDataSoc
    print 'decrypt data right len = ', decryptDataSoc[1]
    print 'decrypt data actual len ', len(decryptDataSoc[0])
    print '-end test  encrypt_buf_and_sign_for_selfchk and decrypt_buf_and_unsign_for_selfchk--\n'

    print "\n-begin test encrypt_and decrypt buf_and_sign_for_remote  mote---"
    myctx5 = id('baidu ADU security 5')
    in_data_soc =  "\xb3\x00&\x00\x00callerid=/listener_4'\x00\x00md5sum=992"
    in_data_soc_len = len(in_data_soc)
    encryptDataSoc = encrypt_buf_and_sign_for_remote(in_data_soc, in_data_soc_len, myctx5)
    print 'encrypt tuple', encryptDataSoc
    print 'encryted data right len  = ', encryptDataSoc[1]
    print 'encrypted Data actual len= ', len(encryptDataSoc[0])
    decryptDataSoc = decrypt_buf_and_unsign_for_remote(encryptDataSoc[0], encryptDataSoc[1], myctx5)
    print 'decrypt tuple', decryptDataSoc
    print 'decrypt data right len = ', decryptDataSoc[1]
    print 'decrypt data actual len ', len(decryptDataSoc[0])
    print '--end test encrypt_buf_and_sign_for_remote and decrypt_buf_and_unsign_for_remote--\n'

    returnCode = free_ctx(myctx1)
    print 'free ctx  return code = ', returnCode

    returnCode = free_ctx_for_python(myctx2)
    print 'free ctx for python return code = ', returnCode

    returnCode = uninit_ros_secure()
    print 'uninit ros secure result = ', returnCode
