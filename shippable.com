language: python
#build_image: shippableimages/ubuntu1204_python

env: 
  - REE=foo TEST=bar
  - secure: TG32BpYxcGmFwmasD2sD9feh2KXaVzQT4SenkaHdBMabNk1YpulsQgVQE2TL0H/ZcZLtlzzWn7LyjgiDXty7L8rfRHNY9+xWUTbEtdUf/kGopOgiYGBSoiuHdQUXjwoczsGtECyeO9+Njub3lBQjkWZwFolNNLdgAwhzXq+MMwrhNJ8TC0RnUS/+8GJd4uGmxOSwpP80eEN8vEBNd/bBzAE7tD8aA6DXDF9gCerw4ASzXteg+CEKZTEFAvFHwT0E7JcwnU+CBHJAw/FvW/48uk03V1S7lwAEfVMz4BVRH9afz5mX0LO40UY60myVcPrhTyrZR48/9Vn6oee4l/pgVg==

python:
  - 2.6
  - 2.7
  - 3.2
  - 3.3
  - 3.4
  - 3.5
  - pypy
  - pypy3

install:
  - pip install -r requirements.txt

# Make folders for the reports
before_script:
  - mkdir -p shippable/testresults
  - mkdir -p shippable/codecoverage

script:
  - which python
  - coverage run `which nosetests` test.py --with-xunit --xunit-file=shippable/testresults/nosetests.xml
  - coverage xml -o shippable/codecoverage/coverage.xml
  - echo "$ZOO"
  #- echo "$BAR"
  - echo "$REE"
  - echo "$TEST"

notifications:
  email:
   - shiphitchcock1@gmail.com 
