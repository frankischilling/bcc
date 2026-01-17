#!/usr/bin/env python3
import re
import sys

# Read the parser section
with open('parser_part.c', 'r') as f:
    content = f.read()

# Remove static keywords from function definitions
content = re.sub(r'^static (void|int|Expr|Stmt|Init|Func|ExternItem|Program|TokenKind|size_t|long) ', r'\1 ', content, flags=re.MULTILINE)
content = re.sub(r'^static ', '', content, flags=re.MULTILINE)

# Remove duplicate type definitions (they're in bcc.h)
# Remove Vec typedef (in bcc.h)
content = re.sub(r'typedef struct Vec \{.*?\} Vec;', '', content, flags=re.DOTALL)
# Remove Expr/Stmt typedefs (forward decls in bcc.h)
content = re.sub(r'typedef struct Expr Expr;', '', content)
content = re.sub(r'typedef struct Stmt Stmt;', '', content)
# Remove all the enum and struct definitions that are in bcc.h
content = re.sub(r'typedef enum \{.*?\} ExprKind;', '', content, flags=re.DOTALL)
content = re.sub(r'struct Expr \{.*?\};', '', content, flags=re.DOTALL)
content = re.sub(r'typedef enum \{.*?\} StmtKind;', '', content, flags=re.DOTALL)
content = re.sub(r'// Declaration item.*?\} DeclItem;', '', content, flags=re.DOTALL)
content = re.sub(r'struct Stmt \{.*?\};', '', content, flags=re.DOTALL)
content = re.sub(r'typedef struct Func \{.*?\} Func;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef enum \{.*?\} InitKind;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef struct Init Init;', '', content)
content = re.sub(r'struct Init \{.*?\};', '', content, flags=re.DOTALL)
content = re.sub(r'typedef enum \{.*?\} ExtVarKind;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef struct \{.*?\} ExternItem;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef enum \{.*?\} TopKind;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef struct Top \{.*?\} Top;', '', content, flags=re.DOTALL)
content = re.sub(r'typedef struct Program \{.*?\} Program;', '', content, flags=re.DOTALL)

# Remove duplicate vec_push and sdup (in util.c)
content = re.sub(r'static void vec_push\(.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n\}', '', content, flags=re.DOTALL)
content = re.sub(r'static char \*sdup\(.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n\}', '', content, flags=re.DOTALL)

# Remove tk_name function (it's in lexer.c)
content = re.sub(r'static const char \*tk_name\(.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n.*?\n\}', '', content, flags=re.DOTALL)

# Add header
content = '#include "bcc.h"\n\n' + content

# Remove "// Forward decls" comment and forward declarations
content = re.sub(r'// Forward decls.*?parse_bin_rhs\(Parser \*P, int min_prec, Expr \*lhs\);', '', content, flags=re.DOTALL)

with open('parser.c', 'w') as f:
    f.write(content)
