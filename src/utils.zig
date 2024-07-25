const std = @import("std");

pub fn log(msg: []const u8) void {
    std.debug.print("{s}\n", .{msg});
}
