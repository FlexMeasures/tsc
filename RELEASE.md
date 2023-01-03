# Release Management


## Release policy

FlexMeasures is released with semantic versioning.

We strive for roughly a release per month.

## Checklist

This checklist guides you through preparing, testing and documenting a release.


- [ ] Decide which commits to main you want to include in the release, and make sure the [corresponding milestone](https://github.com/FlexMeasures/flexmeasures/milestones) is up to date and 100% closed (move open issues to the next milestone, if needed)
- [ ] In case of a patch release:
  - [ ] Backport (locally) to our patch release branch all closed PRs that still have the "Still Needs Manual Backport" label: see https://github.com/FlexMeasures/flexmeasures/pulls?q=is%3Apr+label%3A%22Still+Needs+Manual+Backport%22+is%3Aclosed (one way of doing that is by commenting on the merged PR with "@MeeseeksDev backport to <major>.<minor>.x"
  - [ ] Prepend each commit message with "Backport PR #xxx: " before pushing
  - [ ] Don't forget to remove the label on the GitHub PRs after backporting
- [ ] Check if the changes which happened justify the next version number you had in mind. https://semver.org/ has a helpful guide to differentiate between MAJOR, MINOR, PATCH release:
  1. MAJOR version when you make incompatible API changes,
  2. MINOR version when you add functionality in a backwards compatible manner, and
  3. PATCH version when you make backwards compatible bug fixes.
- [ ] (MINOR or MAJOR) Write a blog post about the added features in Publii.
- [ ] Be sure to work on main: `git checkout main` and `git pull`
- [ ] Test documentation creation: `make update-docs`
- [ ] Run some functionality tests:
  - [ ] Run automated tests via `make test`
  - [ ] Run a fresh interactive test, using [our docker compose stack](https://flexmeasures.readthedocs.io/en/latest/dev/docker-compose.html#seeing-it-work-running-the-toy-tutorial):
    - docker rmi flexmeasures_server flexmeasures_worker
    - docker compose build
    - docker compose up  # already makes a toy account
    - Run the last steps of the tutorial (see link above, adding prices and schedule)
    - Test if a schedule was made, also check in UI
    - Do a quick UI test if possible
    - Run a API test (TODO, maybe script a call to get the tutorial data or add something as well)
- [ ] Update change logs with a commit described with "Prepare changelogs for v<major>.<minor>.<patch> release"
  - [ ] Insert today's date into `documentation/changelog.rst`
  - [ ] (MINOR or MAJOR) Get the blog post's slug (by copying from the localhost preview URL) and link to the post from the changelog.	
  - [ ] Look at `documentation/cli/change_log.rst` to see if we made changes there.
  - [ ] Likewise, look at `documentation/api/change_log.rst`
- [ ] Update dependencies: 
  - [ ] `make freeze-deps`
- [ ] Commit & push
  - local changes (e.g. from the change log updates): `git commit -am "..."`
  - `git push`
  - (PATCH) `git checkout` the patch release branch, backport the change log updates, and `git push` again
  - Add the version tag: `git tag -a vX.Y.Z`
  - `git push --tags` 
- [ ] Create a release on Github based on the new tag  (you can copy the title from your blog post and also paste the change log notes in there; code assets are added automatically)
- [ ] Publish the blog post in Publii ("Sync your website")
- [ ] Check if the documentation builds on [readthedocs.org](https://readthedocs.org/projects/flexmeasures/builds/) (login via Github)
- [ ] Release to Pypi
  - Run `./to_pypi.sh`
  - Test (in some fresh context) if `pip install --upgrade flexmeasures` installs the fresh version
- [ ] Mention the release (with link to the blog post) on the @flexmeasures Twitter account, and other suitable social media accounts
- [ ] In case of a minor release, prepare structure for next minor release cycle
  - [ ] Make a new branch for backporting commits with `git branch <major>.<minor>.x`
  - [ ] Make an empty commit on main (not on the newly created release branch) with `git commit --allow-empty -m "Start <major>.<minor+1>.0"`
  - [ ] `git push`
  - [ ] Tag the new commit with v<major>.<minor+1>.0.dev0
  - [ ] `git push --tags`
- [ ] Create a new version of our Docker image:
  - docker tag flexmeasures_server lfenergy/flexmeasures:v<major>.<minor>
  - docker tag lfenergy/flexmeasures:v<major>.<minor> lfenergy/flexmeasures:latest
  - docker login -u flexmeasures  # Credentials in Seita's credentials store. If using Docker Desktop, you might need to edit ~/.docker/config.json
  - docker push lfenergy/flexmeasures:v<major>.<minor>
  - docker push lfenergy/flexmeasures:latest
  - Check on https://hub.docker.com/r/lfenergy/flexmeasures/tags
- [ ] Close the current milestone and make a new milestone on https://github.com/FlexMeasures/flexmeasures/milestones
- [ ] Update `documentation/changelog.rst` to avoid wasting time on change log merge conflicts later
  - Add a placeholder for the next patch release
  - In case of a minor release, add a placeholder for the next minor release
- [ ] Upgrade dependencies now, so they are well-tested when the next version is released: `make upgrade-dep` Probably good to release this change in a PR to discuss, of course especially if `make test` is not successful. Also, this is a good moment to try removing conflict-related version limits (app.in protects test.in, which protects dev.in) 
  

