class AvatarStyleOption {
  const AvatarStyleOption({
    required this.id,
    required this.label,
    required this.prefix,
  });

  final String id;
  final String label;
  final String prefix;
}

class AvatarOption {
  const AvatarOption({
    required this.key,
    required this.style,
    required this.no,
  });

  final String key;
  final AvatarStyleOption style;
  final int no;
}

const avatarStyleOptions = <AvatarStyleOption>[
  AvatarStyleOption(
    id: 'shapes',
    label: '几何',
    prefix: 'shapes_',
  ),
  AvatarStyleOption(
    id: 'bigears',
    label: '人像',
    prefix: 'bigears_',
  ),
  AvatarStyleOption(
    id: 'bottts',
    label: '机器人',
    prefix: 'bottts_',
  ),
];

AvatarStyleOption avatarStyleById(String? styleId) {
  for (final style in avatarStyleOptions) {
    if (style.id == styleId) {
      return style;
    }
  }
  return avatarStyleOptions.first;
}

AvatarStyleOption? avatarStyleForKey(String? avatarKey) {
  final key = avatarKey?.trim();
  if (key == null || key.isEmpty) {
    return null;
  }
  for (final style in avatarStyleOptions) {
    if (key.startsWith(style.prefix)) {
      return style;
    }
  }
  return null;
}

List<AvatarOption> avatarOptionsForStyle(String styleId) {
  final style = avatarStyleById(styleId);
  return List.generate(
    20,
    (index) => AvatarOption(
      key: '${style.prefix}${index + 1}',
      style: style,
      no: index + 1,
    ),
  );
}

String initialAvatarStyleId(String? avatarKey) {
  return avatarStyleForKey(avatarKey)?.id ?? avatarStyleOptions.first.id;
}

bool isSupportedAvatarKey(String? avatarKey) {
  final key = avatarKey?.trim();
  if (key == null || key.isEmpty || key.length > 64) {
    return false;
  }
  if (!RegExp(r'^[A-Za-z0-9_-]+$').hasMatch(key)) {
    return false;
  }
  final style = avatarStyleForKey(key);
  if (style == null) {
    return false;
  }
  final seed = key.substring(style.prefix.length);
  final no = int.tryParse(seed);
  return no != null && no >= 1 && no <= 20;
}

String? avatarAssetPath(String? avatarKey) {
  final key = avatarKey?.trim();
  final style = avatarStyleForKey(key);
  if (key == null || key.isEmpty || style == null) {
    return null;
  }
  final seed = key.substring(style.prefix.length);
  if (seed.isEmpty) {
    return null;
  }
  final no = int.tryParse(seed);
  if (no == null || no < 1 || no > 20) {
    return null;
  }
  return 'assets/avatars/${style.prefix}$no.png';
}

List<String> allAvatarAssetPaths() {
  return [
    for (final style in avatarStyleOptions)
      for (var index = 1; index <= 20; index++)
        'assets/avatars/${style.prefix}$index.png',
  ];
}
