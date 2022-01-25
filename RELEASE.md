# Release Management


## Release policy

FlexMeasures is released with semantic versioning.

We strive for roughly a release per month.

## Checklist

This checklict guides you through preparing, testing and documenting a release.


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
- [ ] Update change logs with a commit described with "Prepare changelogs for v<major>.<minor>.<patch> release"
  - [ ] Insert today's date into `documentation/changelog.rst`
  - [ ] (MINOR or MAJOR) Get the blog post's slug (by copying from the localhost preview URL) and link to the post from the changelog.	
  - [ ] Look at `documentation/cli/change_log.rst` to see if we made changes there.
  - [ ] Likewise, look at `documentation/api/change_log.rst`
- [ ] Update dependencies: 
  - [ ] `make freeze-deps`
- [ ] Run some tests:
  - [ ] `make test`
  - [ ] a quick UI test
  - [ ] Run a quick API test (TODO)
  - [ ] Run a fresh pip-install test: follow getting-started guide in fresh venv, config file and database. (Notes ― A: aside from the test db, this uses your personal flexmeasures.cfg; B: this could be an opportunity to Dockerize):
    - `mkvirtualenv test-fm-install`
    - `python setup.py install`
    - `export SECRET_KEY=something-secret`
    - `export FLASK_ENV=development`
    - `sudo -i -u postgres`
    - `createdb -U postgres fm_install_test`
    - `createuser --pwprompt -U postgres fm_install_test`  (use "fm_install_test" as password)
    - `exit`
    - `export SQLALCHEMY_DATABASE_URI="postgresql://fm_install_test:fm_install_test@127.0.0.1/fm_install_test"`
    - `flexmeasures --help`  # test startup & CLI commands
    - `flexmeasures db upgrade`
    - `flexmeasures add account --name "Acme Corp."`
    - `flexmeasures add user --username bla --email bla@blupp.com  --account-id 1`
    - `flexmeasures dev-add generic-asset-type --name power-generator`
    - `flexmeasures dev-add generic-asset --name turbine --generic-asset-type-id 1 --latitude 50.8 --longitude 3.3 --account-id 1`
    - `flexmeasures dev-add sensor --name power --unit MW --event-resolution 5 --timezone Europe/Amsterdam --generic-asset-id 1 --attributes '{"capacity_in_mw": 7}'`
    - `flexmeasures run`  # test that UI starts, bla user can log in and sees his asset and sensor
    - `deactivate && rmvirtualenv test-fm-install`
    - `sudo -i -u postgres`
    - `dropdb fm_install_test && dropuser fm_install_test && exit`
    - `workon <your usual dev virtualenv> ` # make sure you re-activate your original venv
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
- [ ] In case of a minor release, prepare structure for next minor release cycle
  - [ ] Make a new branch for backporting commits with `git branch <major>.<minor>.x`
  - [ ] Make an empty commit on main (not on the newly created release branch) with `git commit --allow-empty -m "Start <major>.<minor+1>.0"`
  - [ ] `git push`
  - [ ] Tag the new commit with v<major>.<minor+1>.0.dev0
  - [ ] `git push --tags`
- [ ] Close the current milestone and make a new milestone on https://github.com/FlexMeasures/flexmeasures/milestones
- [ ] Update `documentation/changelog.rst` to avoid wasting time on change log merge conflicts later
  - Add a placeholder for the next patch release
  - In case of a minor release, add a placeholder for the next minor release
- [ ] Upgrade dependencies now, so they are well-tested when the next version is released: `make upgrade-dep` Probably good to release this change in a PR to discuss, of course especially if `make test` is not successful. Also, this is a good moment to try removing conflict-related version limits (app.in protects test.in, which protects dev.in) 
  

