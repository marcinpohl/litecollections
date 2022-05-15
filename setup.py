from __future__ import print_function
from distutils.core import setup
import sys, os, setuptools

version = '2022.5.15.2'
name = 'litecollections'

packages = setuptools.find_packages()

assert name in packages, [name, packages]  # if package name doesnt show up, something is wrong

setup(
  name = name,
  version = version,
  packages = packages,
  install_requires = [],
  zip_safe=True,
  description = 'python collections except its all backed by sqlite',
  author = 'Cody Kochmann',
  author_email = 'kochmanncody@gmail.com',
  url = 'https://github.com/CodyKochmann/litecollections',
  download_url = 'https://github.com/CodyKochmann/litecollections/tarball/{}'.format(version),
  keywords = ['sqlite', 'collections', 'persistent', 'performance', 'scale', 'datascience', 'acid', 'database'],
  classifiers = []
)
