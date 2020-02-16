import setuptools

# Upload:
# rm -rf build/ csmgr.egg-info/ dist/
# python3 setup.py sdist bdist_wheel --universal
# python3 -m twine upload dist/*

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
     name='cscope-manager',
     version='1.0.2',
     scripts=['csmgr'] ,
     author="Rick Chang",
     author_email="chchang915@gmail.com",
     description="A tool helps you manage cscope/ctags tags",
     long_description=long_description,
   long_description_content_type="text/markdown",
     url="https://github.com/susu9/cscope-manager",
     license='Apache License 2.0',
     packages=setuptools.find_packages(),
     python_requires='>=2.7, !=3.0.*, !=3.1.*, !=3.2.*, !=3.3.*',
     classifiers=[
         "Programming Language :: Python :: 2.7",
         "Programming Language :: Python :: 3.4",
         "Programming Language :: Python :: 3.5",
         "Programming Language :: Python :: 3.6",
         "Programming Language :: Python :: 3.7",
         "License :: OSI Approved :: Apache Software License",
         "Operating System :: OS Independent",
     ],
 )
