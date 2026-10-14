#include <greeter/build_info.h>
#include <greeter_config.h>


namespace greeter {

	std::string get_build_system() {
		return GREETER_SYSTEM;
	};

	std::string get_build_info() {
		return "built on " + get_build_system() + " with " + GREETER_COMPILER;
	};

}

