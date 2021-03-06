# Linux.Wifatch source repository

This is official Linux.Wifatch sources

This repository contain all local components (missing files are
unintentional and/or will be added later), additional C source code not
part of the botnet install, and selected C&C components. More can come
over time.

## Structure

* `bn/` is the binary botnet component, i.e. perl (`.net_bn`)

   * `bn/bnperl/' a custom perl module linked into the binary.

* `pl/` is the perl botnet component (`.net_pl`)

* `pl/bn/` contains the perl botnet modules,

* `pl/fn/` contains botnet commands (first argument on command line)

* `pl/tn/` contains low-level botnet components, heavily size-optimised

   * `pl/tn/pa.c` print-architecture, executed to see if architecture matches

   * `pl/tn/rf.c` receive-file, receive file on stdin, write to disk

   * `pl/tn/dl.c` download, download a file via botnet protocol

   * `pl/tn/tn.c` "telnet" - simple authenticated command/fileserver. last
      component installed before main botnet.

* `cc/` contains some command & control infrastructure

   * `cc/bm/` contains "command & control" perl modules, also uses `pl/bn/` modules

   * `cc/bin/` contains commandline programs and daemons

The directory structure is not most convenient for usage, but was made so
it hopefully is easier to distinguish components.

The components that actually execute on infected devices are
the `pl/` ones and `bn/` ones.

In addition, standard third party code is used, such as various CPAN
modules, the dropbear ssh client and staticperl.

This is the list of third-party perl modules (their dependencies are not
listed). Thanks a lot to these authors, without whose work this wouldn't
be possible.

   POSIX Socket URI Array::Heap Filesys::Statvfs Convert::Scalar Guard
   EV CBOR::XS MIME::Base64 AnyEvent AnyEvent::Fork AnyEvent::Fork::RPC
   AnyEvent::Fork::Pool Coro Compress::LZF Set::IntSpan BSD::Resource
   Math::TrulyRandom GDBM_File AnyEvent::HTTP Filter::Util::Call
   Sub::Uplevel

# Contact

In case of problem, question, missing files: ask, but do not expect speedy
reply!

The White Team <rav7teif@ya.ru>

# Q&A

* Why did you write this and let it go?

  First, for learning. Second, for understanding. Third, for fun, and
  fourth, for your (and our) security. Apart from the learning experience,
  this is a truly altruistic project, and no malicious actions are planned
  (and it is nice touch that Symantec watch over this).

* Why release now?

  It was never intended to be secret. And to be truly ethical (Stallman
  said) it needs to have a free license (agreed) and ask before acting (also
  agreed, so we are only half way there).

* Why not release earlier?

  To avoid unwanted attention, especially by other mlaware authors who
  want to avoid detection. The plan failed, unwanted attention has been
  attracted, so there are no reasons not to release anymore.

* Who are you?

  We are nobody important. Really.

* Do you feel bad about abusing resources by others?

  Yes, although the amount of saved bandwidth by taking down other
  scanning malware, the amount energy saved by killing illegal bitcoin
  miners, the number of reboots and service interruptions prevented by
  not overheating these devices, the number of credentials and money not
  stolen should all outweigh this.
  
  We co-opted your devices to help the general public (in a small way).

* Can I trust you to not do evil things with my devices?

  As a matter of fact, yes, but that is of no practical help - somebody
  could steal the botnet key, no matter how well I protect it. And
  software is never perfect - chances are there is a bug in the code that
  allows access to anybody (even though multiple researchers tries but
  failed to find one). And in the end, it's a common trick by fraudsters
  to assure people that they are trustworthy.

* Should I trust you?

  No. This does not mean that we don't promise to screw you (we herewith
  do promise to not screw you intentionally), it means you should not rely
  on us to keep you safe, because we might not be able to. Instead, you
  should reassert control of your device and close the obvious security
  holes and look for firmware updates regularly.

  If you do that, then you don't have to worry whether to trust us or not.

* Aren't devices mostly secure until you hack them with elaborate exploits?

  Linux.Wifatch doesn't use elaborate backdoors or 0day exploits to
  hack devices. It basically just uses telnet and a few other protocols
  and tries a few really dumb or default passwords (our favourite is
  "password").
  
  These passwords are well-known - almost anybody can do that. And a lot
  of people with much less friendly intentions actively do that.

  Basically it only infects devices that are not protected at all in the
  first place!

* What license is this?

  Apart from some code copied from other sources (where marked), the intent
  is for all this code to be under the General Public License, version 3 or
  any later version. See the file `COPYING` for details.

* Where is the Stallman quote comment?

  There never was such a comment. The quote was used as telnet message
  for a while. We agree with it, but found it a bit silly to use it as a
  telnet banner, so removed it after a short time. Here is his quote:

  To any NSA and FBI agents reading my email: please consider
  whether defending the US Constitution against all enemies,
  foreign or domestic, requires you to follow Snowden's example.

* The passwords/secret keys are missing from the sources!

  Well, we hope they are missing. This release is for releasing the code,
  not to make it easy to hack others, or to actually run it.

* Where is the infection code?

  Not here, it part of the command and control code. It might be released
  when it no longer is relevant, to protect the innocent.

* Where are the build scripts?

  Not part of the initial release. Shouldn't keep you from studying, if
  that is your plan.

* How many infected devices are there, really?

  It is quite hard to measure the exact size of a network that constantly
  changes.

  We enumerate the whole core network (the so-called "bn" component)
  multiple times a day, and the usual number of Wifatch instances is 60000
  (and almost never exceeding 120000). Only these are currently being
  protected and disinfected.

  In addition, there is a much larger number of devices with a much
  smaller component, the so-called "tn" component. The exact number of
  these is very hard to measure, but it should be around 200000-300000
  at any point in time.

* Is there a proof that this is the official repository?

  Here is a nistp256 signature of the sha256 of the repository URL on
  gitlab, using the actual signing key used for the real version.

  http://gitlab.com/rav7teif/linux.wifatch

  3678992952743f6596730c8936263ecdaca200f0aa87a3bf6d287561d1a55c4c
  a331e24b1d6aae7e8983adb9a9b9f68b3dc609278593bdbfbf60556a8acc42e2

  It is a bit difficult to verify, here are some hints:

  The key used to sign this is in the `.net_bn` binary, and also here:

  04
  c4f189f8a4b046dfc758920b9369f496ca81e8fa02b0ceacb5adade0adcbf9bd
  e860c21cfe2cb31d5a97ce0dcd829efb62f8a28156011aeb26a59cc87a4a8835

  Here is a python snippet to verify (not output means success):

  > import hashlib
  >
  > import binascii
  > from ecdsa import NIST256p, VerifyingKey
  >
  > sig = binascii.unhexlify ('3678992952743f6596730c8936263ecdaca200f0aa87a3bf6d287561d1a55c4ca331e24b1d6aae7e8983adb9a9b9f68b3dc609278593bdbfbf60556a8acc42e2')
  > pubkey = binascii.unhexlify ('c4f189f8a4b046dfc758920b9369f496ca81e8fa02b0ceacb5adade0adcbf9bde860c21cfe2cb31d5a97ce0dcd829efb62f8a28156011aeb26a59cc87a4a8835')
  > message = 'http://gitlab.com/rav7teif/linux.wifatch'
  > vk = VerifyingKey.from_string (pubkey,curve = NIST256p)
  > vk.verify(sig, message, hashfunc = hashlib.sha256)

