type RemovalInput = { workId?: unknown; creditId?: unknown; reason?: unknown };
const uuid = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export function parseWorkCreditRemoval(input: RemovalInput) {
  const workId = typeof input.workId === "string" ? input.workId.trim() : "";
  const creditId = typeof input.creditId === "string" ? input.creditId.trim() : "";
  const reason = typeof input.reason === "string" ? input.reason.trim() : "";
  if (!uuid.test(workId) || !uuid.test(creditId)) {
    return { ok: false as const, error: "A valid Work and composition credit are required." };
  }
  if (!reason || reason.length > 2000) {
    return { ok: false as const, error: "Enter a removal reason of up to 2,000 characters." };
  }
  return { ok: true as const, workId, creditId, reason };
}

type RpcResult = { data: unknown; error: { code?: string; message: string } | null };
type RemovalDependencies = {
  remove: (input: { workId: string; creditId: string; reason: string }) => PromiseLike<RpcResult>;
  refresh: (workId: string) => Promise<unknown>;
};

export async function executeWorkCreditRemoval(input: RemovalInput, dependencies: RemovalDependencies) {
  const parsed = parseWorkCreditRemoval(input);
  if (!parsed.ok) return { status: 400, body: { ok: false, error: parsed.error } };
  const result = await dependencies.remove(parsed);
  if (result.error) {
    const unavailable = result.error.code === "PGRST202" || result.error.code === "42883";
    return {
      status: unavailable ? 503 : result.error.code === "42501" ? 403 : 400,
      body: { ok: false, error: unavailable
        ? "Credit removal is not enabled in this database yet. The owner must apply the reviewed database proposal."
        : result.error.message },
    };
  }
  await dependencies.refresh(parsed.workId);
  return { status: 200, body: { ok: true, result: result.data } };
}
