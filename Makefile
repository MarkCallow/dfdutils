out := out

targets := testcreatedfd testinterpretdfd testbidirectionalmapping docs

all: $(addprefix out/,${targets})

# Note. Currently we use an unreleased version of vulkan_core.h with enums
# for ASTC 3D. Since this is temporary, the sources still use <angled>
# includes. The -I. causes our local copy to be found while the VULKAN_SDK
# part keeps compilers from warning that the file was not found with
# <angled> include.
$(out)/testcreatedfd: createdfd.c createdfdtest.c printdfd.c KHR/khr_df.h dfd.h | out
	gcc createdfdtest.c createdfd.c printdfd.c -I. $(if VULKAN_SDK,-I${VULKAN_SDK}/include) -o $@ -std=c99 -W -Wall -pedantic -O2 -Wno-strict-aliasing

$(out)/testinterpretdfd: createdfd.c interpretdfd.c interpretdfdtest.c printdfd.c KHR/khr_df.h dfd.h | out
	gcc interpretdfd.c createdfd.c interpretdfdtest.c printdfd.c -o $@ -I. $(if VULKAN_SDK,-I${VULKAN_SDK}/include) -O -W -Wall -std=c99 -pedantic

$(out)/testbidirectionalmapping: testbidirectionalmapping.c interpretdfd.c createdfd.c KHR/khr_df.h dfd.h | out
	gcc testbidirectionalmapping.c interpretdfd.c createdfd.c -o $@ -I. $(if VULKAN_SDK,-I${VULKAN_SDK}/include) -g -W -Wall -std=c99 -pedantic

$(out)/docs: createdfd.c createdfdtest.c printdfd.c KHR/khr_df.h dfd.h | out
	doxygen dfdutils.doxy

build out:
	mkdir -p $@

clean:

clobber: clean
	rm -rf $(addprefix out/,${targets})

switches: dfd2vk.inl vk2dfd.inl

dfd2vk.inl: vulkan/vulkan_core.h makedfdtovk.pl
	./makedfdtovk.pl $< $@

vk2dfd.inl: vulkan/vulkan_core.h makevkswitch.pl
	./makevkswitch.pl $< $@

# For those who wish to generate a project from the gyp file so
# as to use xcode for debugging.
xcodeproj: build/project.pbxproj
build/project.pbxproj: dfdutils.gyp | build
	gyp -f xcode -DOS=mac --generator-output=build --depth=.

