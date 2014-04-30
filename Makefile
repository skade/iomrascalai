########################################################################
#                                                                      #
# Copyright 2014 Urban Hafner                                          #
#                                                                      #
# This file is part of Iomrascálaí.                                    #
#                                                                      #
# Iomrascálaí is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by #
# the Free Software Foundation, either version 3 of the License, or    #
# (at your option) any later version.                                  #
#                                                                      #
# Iomrascálaí is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of       #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
# GNU General Public License for more details.                         #
#                                                                      #
# You should have received a copy of the GNU General Public License    #
# along with Iomrascálaí.  If not, see <http://www.gnu.org/licenses/>. #
#                                                                      #
########################################################################

MAIN   = src/iomrascalai.rs
CRATES = src/board/mod.rs

all: exe

TO_LIB = $(addprefix lib/, $(shell rustc --crate-file-name $(1)))
LIBS   = $(foreach crate, $(CRATES), $(call TO_LIB, $(crate)))
define COMPILE_CRATE
$(call TO_LIB, $(1)): $(1)
	rustc --out-dir lib $(1)
endef
$(foreach crate, $(CRATES), $(eval $(call COMPILE_CRATE, $(crate))))

exe: $(MAIN) $(LIBS)
	rustc --out-dir bin -L lib $(MAIN)

libs: $(LIBS)
	
.PHONY: clean
clean:
	rm -f bin/*
	rm -f lib/*
