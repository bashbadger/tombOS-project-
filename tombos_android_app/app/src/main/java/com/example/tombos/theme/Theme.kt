package com.example.tombos.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext

private val DarkColorScheme = darkColorScheme(
  primary = TurtleNeonGreen,
  secondary = TurtleOliveSecondary,
  tertiary = TurtleDeepGreen,
  background = TurtleDarkShell,
  surface = TurtleDarkShell
)

private val LightColorScheme = lightColorScheme(
  primary = TurtleOliveSecondary,
  secondary = TurtleDeepGreen,
  tertiary = TurtleNeonGreen
)

@Composable
fun TombOSTheme(
  darkTheme: Boolean = isSystemInDarkTheme(),
  dynamicColor: Boolean = false,
  content: @Composable () -> Unit,
) {
  val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme

  MaterialTheme(colorScheme = colorScheme, typography = Typography, content = content)
}
