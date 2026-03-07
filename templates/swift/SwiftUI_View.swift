//
// {{_file_name_}}.swift
// {{_lua:vim.fn.fnamemodify(vim.fn.getcwd(), ":t")_}}
//
// Created by {{_author_}} on {{_lua:os.date("%d/%m/%y")_}}.
// Copyright © {{_lua:os.date("%Y")_}} {{_lua:vim.g.organization_}}. All rights reserved.
//

import SwiftUI

struct {{_file_name_}}: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    {{_file_name_}}()
}
