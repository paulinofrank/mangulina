import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const USER = "demo";
const PASS = "secret";

// Encode "user:password" in Base64
const BASIC_AUTH = "Basic " + Buffer.from(`${USER}:${PASS}`).toString("base64");

export function middleware(req: NextRequest) {
  const auth = req.headers.get("authorization");

  if (auth === BASIC_AUTH) {
    return NextResponse.next();
  }

  return new NextResponse("Authentication required", {
    status: 401,
    headers: {
      "WWW-Authenticate": 'Basic realm="Secure Area"',
    },
  });
}

export const config = {
  matcher: ["/((?!_next/static|_next/image|favicon.ico).*)"],
};
