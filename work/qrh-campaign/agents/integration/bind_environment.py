from pathlib import Path
p=Path('work/qrh-campaign/agents/integration/build_project.py')
s=p.read_text()
s=s.replace('def main():', "def environment_identity(package_paths):\n    return {'lean_binary_sha256': digest(LEAN),\n            'lean_options': ['-j', '2', '-R', str(SOURCE)],\n            'package_paths': [str(path.resolve()) for path in package_paths],\n            'project_manifest_sha256': digest(SOURCE / 'lake-manifest.json')}\n\ndef main():")
s=s.replace("    environment = dict(os.environ)", "    environment_key = environment_identity(package_paths)\n    environment = dict(os.environ)")
s=s.replace("        binding = {\n            'source_sha256':", "        binding = {\n            'environment': environment_key,\n            'source_sha256':")
s=s.replace("        key = {'module': module,", "        key = {'environment': environment_key, 'module': module,")
p.write_text(s)
