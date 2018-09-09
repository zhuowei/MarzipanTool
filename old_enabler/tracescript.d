proc:::start /execname == "UIKitHostApp"/ {
	printf("New UIKit window!\n");
	raise(SIGSTOP);
	system("lldb -p %d -s uikitenabler.lldb", pid);
}
