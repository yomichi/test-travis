## rewrite TODO sections for your project

# This is a pull request, finish.
if [ "_$TRAVIS_PULL_REQUEST" != "_false" ] ;then exit 0; fi
# This is neither master nor tag, finish.
if [ "_$TRAVIS_BRANCH" != "_master" ] && [ -z "$TRAVIS_TAG" ] ; then exit 0; fi

## TODO
git config --global user.email "yomichi@tsg.jp"
git config --global user.name "Yuichi Motoyama"
openssl aes-256-cbc -K $encrypted_12106f7bbd8a_key -iv $encrypted_12106f7bbd8a_iv -in ssh_key.enc -out ~/.ssh/id_rsa -d

chmod 600 ~/.ssh/id_rsa
echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
git remote set-url origin git@github.com:${TRAVIS_REPO_SLUG}
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch --unshallow origin
git checkout gh-pages


## TODO
DOCDIR=docs/${TRAVIS_BRANCH}
mkdir -p ${DOCDIR}
rm -rf ${DOCDIR}
mkdir -p ${DOCDIR}/jp/
mkdir -p ${DOCDIR}/en/
cp -r build/doc/jp/html/* ${DOCDIR}/jp
cp -r build/doc/en/html/* ${DOCDIR}/en
cp -r build/doc/jp/pdf/test_travis.pdf ${DOCDIR}/jp
cp -r build/doc/en/pdf/test_travis.pdf ${DOCDIR}/en
git add ${DOCDIR}
git commit -m "Update by TravisCI (${TRAVIS_BUILD_ID})"
ST=$?
if [ $ST == 0 ]; then
  git push origin gh-pages:gh-pages --follow-tags > /dev/null 2>&1
fi

git checkout master
