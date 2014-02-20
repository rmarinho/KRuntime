﻿using System;
using System.Reflection;
using Microsoft.Net.Runtime;

namespace klr.host
{
    public class DefaultLoaderEngine : IAssemblyLoaderEngine
    {
        private readonly object _loaderImpl;
        private readonly Func<string, Assembly> _loadFile;
        private readonly Func<byte[], byte[], Assembly> _loadBytes;

        public DefaultLoaderEngine(object loaderImpl)
        {
            _loaderImpl = loaderImpl;

            var typeInfo = loaderImpl.GetType().GetTypeInfo();
            var loaderFileMethod = typeInfo.GetDeclaredMethod("LoadFile");
            var loadBytesMethod = typeInfo.GetDeclaredMethod("LoadBytes");

            _loadFile = (Func<string, Assembly>)loaderFileMethod.CreateDelegate(typeof(Func<string, Assembly>), _loaderImpl);
            _loadBytes = (Func<byte[], byte[], Assembly>)loadBytesMethod.CreateDelegate(typeof(Func<byte[], byte[], Assembly>), _loaderImpl);
        }

        public Assembly LoadFile(string path)
        {
            return _loadFile(path);
        }

        public Assembly LoadBytes(byte[] assemblyBytes, byte[] pdbBytes)
        {
            return _loadBytes(assemblyBytes, pdbBytes);
        }
    }
}