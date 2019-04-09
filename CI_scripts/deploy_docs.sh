#!/bin/bash -x

set -e

# This is a pull request, finish.
if [ "_$TRAVIS_PULL_REQUEST" != "_false" ] ;then travis_terminate 0; fi
# This is neither master nor tag, finish.
if [ "_$TRAVIS_BRANCH" != "_master" ] && [ -z "$TRAVIS_TAG" ] ; then travis_terminate 0; fi

git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch # --unshallow
git checkout gh-pages
DOCDIR=docs/${TRAVIS_BRANCH}
mkdir -p ${DOCDIR}/jp/
mkdir -p ${DOCDIR}/en/
cp -r build/doc/jp/html/* ${DOCDIR}/jp
# cp -r build/doc/jp/pdf/test_travis.pdf ${DOCDIR}/jp
cp -r build/doc/en/html/* ${DOCDIR}/en
# cp -r build/doc/en/pdf/test_travis.pdf ${DOCDIR}/en
git add ${DOCDIR}
set +e
git commit -m "Update by TravisCI"
ST=$?
set -e
if [ $ST == 0 ]; then
  git push "https://${GH_TOKEN}@github.com/yomichi/test-travis.git" gh-pages:gh-pages --follow-tags > /dev/null 2>&1
fi

