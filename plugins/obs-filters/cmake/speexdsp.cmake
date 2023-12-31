option(ENABLE_SPEEXDSP "Enable building with SpeexDSP-based noise suppression filter" ON)

if(ENABLE_SPEEXDSP)
  find_package(Libspeexdsp REQUIRED)

  target_sources(obs-filters PRIVATE noise-suppress-filter.c)
  target_link_libraries(obs-filters PRIVATE SpeexDSP::Libspeexdsp)
  target_compile_definitions(obs-filters PRIVATE LIBSPEEXDSP_ENABLED)
  target_link_options(obs-filters PRIVATE $<$<AND:$<PLATFORM_ID:Windows>,$<CONFIG:Debug>>:/NODEFAULTLIB:MSVCRT>)

  target_enable_feature(obs-filters "SpeexDSP noise suppression" HAS_NOISEREDUCTION)
else()
  target_disable_feature(obs-filters "SpeexDSP noise suppression")
endif()
