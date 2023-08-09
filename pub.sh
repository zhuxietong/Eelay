pod lib lint
tag='5.3.7'
git add -A && git commit -m "${tag}"
git tag $tag
git push --tags
pod trunk push Eelay.podspec
