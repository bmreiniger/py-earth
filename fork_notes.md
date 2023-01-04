The main project has long been abandoned.  It has a branch `v0.2dev` that has generally worked to install from,
but newer versions of python and the rest of the ecosystem has made it more and more fragile.
Here I'll attempt to bring it back up to standard installation.
I'd love to try to take ownership and address other issues, but probably don't have the time or technical skills.

I'm going to log changes here rather than doing nice small git commits, because I don't know what I'm doing,
and this seems easier to revert things as I go (sorry!).

Changes
-------
nosetest is [also abandoned](https://github.com/nose-devs/nose/issues/1099).  Moving to pytest (TODO: not completely moved).

Installation required rebuilding .pyx files to .c using a current cython.
For some reason I couldn't get it to do all of them at once; luckily there aren't many to do manually:
```cython pyearth/_basis.pyx```
etc.  This has fixed the main issue I had pip-installing from `v0.2dev`, an error with a header file `longintrepr.h`.
(I can now see that re-building has put an if-guard around that import.)

Fixed little (esp. future) warnings (`description-file` -> `description_file`, etc.)

I just deleted the conda-build recipe entirely; I don't get it.
Might be worth going back and looking at the main repo to see about re-adding it.

`test_qr.py::test_updating_qr_with_lienar_dependence` was failing, with `u` failing to set some below-diagonal entries to zero.
I'm not sure yet whether that matters for the consumers of the QR decomp:
if so, then we should set them to zero -- I've initialized the T array as zeros instead of empty to accomplish this;
if not, then we could just modify the test to ignore below-diagonal entires -- this would be faster, but for safety I've assumed the former.

`test_earth.py::test_output_weight` fails when I run the whole test suite, but not when I run it individually...

While developing, I need to run `make inplace` to rebuild between tests. I'm newish to cython; is this standard, or is there a slicker way?
