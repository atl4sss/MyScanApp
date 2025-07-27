# export_to_mobile.py
from pathlib import Path
import torch, torch.nn as nn, torchvision.models as M
from torch.utils.mobile_optimizer import optimize_for_mobile   # ✓

HERE = Path(__file__).resolve().parent          # mobapp/
ROOT = HERE.parent                              # корень проекта
SRC  = ROOT / 'health_bot'
DST  = HERE / 'assets' / 'models'
DST.mkdir(parents=True, exist_ok=True)

# ── helpers ─────────────────────────────────────────────────────────────
def _effb0(nc: int):
    m = M.efficientnet_b0()
    m.classifier[1] = nn.Linear(m.classifier[1].in_features, nc)
    return m

def _res34(nc: int):
    m = M.resnet34()
    m.fc = nn.Linear(m.fc.in_features, nc)
    return m

def _res50(nc: int):
    m = M.resnet50()
    m.fc = nn.Linear(m.fc.in_features, nc)
    return m

MAP = {
    'lungs': (SRC/'chest_xray'/'model'/'lung_model.pth',  _effb0, 2),
    'oct'  : (SRC/'OCT2017'    /'model'/'oct_model.pth',  _res34, 4),
    'brain': (SRC/'brain_mri'  /'model'/'brain_model.pth',_res50, 4),
}

# ── export loop ────────────────────────────────────────────────────────
def export(tag: str, pth: Path, builder, n_cls: int):
    if not pth.exists():
        raise FileNotFoundError(pth)
    print(f'→ конвертация {pth.relative_to(ROOT)} → {tag}.ptl')

    net = builder(n_cls)
    net.load_state_dict(torch.load(pth, map_location='cpu'))
    net.eval()

    traced = torch.jit.trace(net, torch.randn(1, 3, 224, 224))
    mobile = optimize_for_mobile(traced)              # оптимизация Lite

    out_path = DST / f'{tag}.ptl'
    # ---------- главное изменение: передаём строку -----------
    mobile._save_for_lite_interpreter(str(out_path))  # 👈
    # ---------------------------------------------------------
    print('  ✓ сохранено', out_path.relative_to(ROOT))

for tag, cfg in MAP.items():
    export(tag, *cfg)
