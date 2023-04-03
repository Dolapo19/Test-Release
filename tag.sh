#!/bin/bash
#hello world
#tag is tagging
# Define variables
tag_name="$TAG_NAME"
commit_sha="$(git rev-parse HEAD)"
remote_url="$(git remote get-url origin)"
release_version="$RELEASE_VERSION"

# Check if the tag exists in the repository
if git rev-parse -q --verify "refs/tags/$tag_name" >/dev/null; then
  echo "The tag $tag_name already exists in the repository"
else
  echo "Creating tag $tag_name and pushing to remote repository"
  git tag -a "$tag_name" -m "Version $tag_name" "$commit_sha"
  git push "$remote_url" "$tag_name"
fi

# Check if the release version already exists
if git rev-parse -q --verify "refs/tags/$release_version" >/dev/null; then
  echo "The release version $release_version already exists in the repository"
  exit 0
else
  echo "Creating release version $release_version and pushing to remote repository"
  git tag -a "$release_version" -m "Release version $release_version" "$commit_sha"
  git push "$remote_url" "$release_version"
  exit 0
fi

