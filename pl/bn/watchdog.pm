#
# This file is part of Linux.Wifatch
#
# Copyright (c) 2013,2014,2015 The White Team <rav7teif@ya.ru>
#
# Linux.Wifatch is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Linux.Wifatch is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Linux.Wifatch. If not, see <http://www.gnu.org/licenses/>.
#

package bn::watchdog;

# keep parent from restarting us

our $TIMER;

sub reset
{
	$TIMER = EV::timer $bn::SAFE_MODE ? 32401 : 616513, 0, sub {
		syswrite $bn::SAFE_PIPE, "\xfd";
		POSIX::_exit 0;
	};
}

bn::watchdog::reset;

1

